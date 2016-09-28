#! /usr/bin/env python
from __future__ import print_function

import os
import sys
import argparse
from subprocess import CalledProcessError

from scripting.conda import install_python
from scripting.contexts import cd, homebrew_hidden, setenv
from scripting.unix import system, which, check_output
from scripting.prompting import prompt, status, success
from scripting.git import git_clone_or_update
from scripting.termcolors import blue


RECIPES = ['boost-headers', 'libiconv', 'libxml2', # 'ncurses',
           'chasm', 'cca-babel', 'cca-spec-babel', 'ccaffeine',
           'cca-bocca', ]


def build_env(which_gfortran=None, which_python=None):
    which_gfortran = which_gfortran or which('gfortran')
    which_python = which_python or which('python')

    prefix = os.path.dirname(os.path.dirname(which_gfortran))

    which_gcc = os.path.join(prefix, 'bin', 'gcc')
    which_gxx = os.path.join(prefix, 'bin', 'g++')

    ver = check_output([which_gfortran, '-dumpversion']).split('.')
    gcc_version = ver[0] + ver[1]

    env = {
        'COMPILER': 'gcc' + gcc_version,
        'PATH': os.pathsep.join([
            os.path.dirname(which_gfortran),
            os.path.dirname(which_python),
            '/usr/bin', '/bin', '/usr/sbin', '/etc', '/usr/lib', ]),
        'CC': which_gcc,
        'CXX': which_gxx,
        'FC': which_gfortran,
    }

    return env


def conda_build_output(recipe):
    path_to_file = check_output(['conda', 'build', recipe, '--output'])
    return path_to_file.strip()


def install_internal_python(prefix, batch_mode=False):
    if prompt('ok to install python in {prefix}'.format(prefix=prefix),
              batch_mode=batch_mode):
        python_prefix = install_python(prefix=prefix,
                                       packages=('conda-build',
                                                 'anaconda-client'))
        which_python = os.path.join(python_prefix, 'bin', 'python')
    else:
        which_python = None

    return which_python


def main():
    parser = argparse.ArgumentParser(
        description='Build the CSDMS software stack',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('prefix', help='path to python installation')
    parser.add_argument('recipe', nargs='*',
                        help='recipes to build')
    parser.add_argument('-b', '--batch', action='store_true',
                        help='Run in batch mode')
    parser.add_argument('--which-gfortran', default=which('gfortran'),
                        help='Path to gfortran')
    parser.add_argument('--which-python', default='internal', 
                        help='Path to python')

    args = parser.parse_args()

    recipes = args.recipe or RECIPES

    which_gfortran = args.which_gfortran
    if which_gfortran is not None and os.path.isdir(which_gfortran):
        which_gfortran = os.path.join(which_gfortran, 'bin', 'gfortran')

    which_python = args.which_python or which('python')
    if which_python == 'internal':
        which_python = install_internal_python(args.prefix,
                                               batch_mode=args.batch)

    if which_python is None:
        print('Missing Python', file=sys.stderr) and sys.exit(1)
    if which_gfortran is None:
        print('Missing gfortran', file=sys.stderr) and sys.exit(1)

    with cd(args.prefix):
        git_clone_or_update('https://github.com/csdms/csdms-stack',
                            dir='csdms-stack')
        recipe_dir = os.path.join(args.prefix, 'csdms-stack', 'conda-recipes')

    env = build_env(which_gfortran=which_gfortran, which_python=which_python)
    status('Building with this environment:')
    for key, val in env.items():
        print('{k}={v}'.format(k=blue(key), v=blue(val)), file=sys.stdout)

    status_code = 0
    files_to_upload = []
    with cd(recipe_dir):
        with homebrew_hidden(prompt=not args.batch):
            with setenv(env):
                system(['conda', 'clean', '--all'])
                for recipe in recipes:
                    try:
                        system(['conda', 'build', recipe])
                    except CalledProcessError:
                        status_code = 1
                        break
                    else:
                        files_to_upload.append(conda_build_output(recipe))

    for fname in files_to_upload:
        success('created: {fname}'.format(fname=fname))

    if prompt('ok to upload to Anaconda cloud', batch_mode=args.batch):
        for fname in files_to_upload:
            try:
                system(['anaconda', 'upload', '--force', '--channel', 'nightly',
                        '--user', 'csdms', fname])
            except CalledProcessError:
                status_code = 1
            else:
                success('uploaded: {fname}'.format(fname=fname))

    return status_code


if __name__ == '__main__':
    sys.exit(main())
