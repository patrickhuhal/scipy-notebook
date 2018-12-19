ARG baseimg=jupyter/scipy-notebook

#power9
#ARG baseimg=nvidia/cuda-ppc64le:9.2-devel-ubuntu18.04

#intel
#ARG baseimg=nvidia/cuda:9.0-devel-ubuntu16.04

FROM $baseimg

#power8
ARG appdef=AppDef.json
ARG sample=9-2
        
RUN curl -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/nimbix/image-common/master/install-nimbix.sh | bash

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/nvidia-384:/usr/lib/nvidia-390:/usr/lib/nvidia-396
RUN cd /usr/local/cuda/samples && make -j16 -k ; exit 0
RUN ls -l /usr/lib

COPY url.txt /etc/NAE/url.txt
COPY help.html /etc/NAE/help.html
COPY $appdef /etc/NAE/AppDef.json
RUN wget --post-file=/etc/NAE/AppDef.json --no-verbose https://api.jarvice.com/jarvice/validate -O -

# Expose port 22 for local JARVICE emulation in docker
EXPOSE 22


