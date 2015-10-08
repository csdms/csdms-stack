#! /bin/bash

#conda build gettext
#conda build glib && \
#conda build libffi && \
#conda build netcdff && \

conda build libxml2 && \
conda build boost-headers && \
conda build chasm && \
conda build cca-babel

#conda build cca-spec-babel && \
#conda build ccaffeine && \
#conda build cca-bocca && \
#conda build bmi-babel && \
#conda build csdms-components && \
#conda build esmf && \
#conda build esmpy && \
#conda build coupling && \
#conda build wmt-exe
