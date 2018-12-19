ARG baseimg=jupyter/scipy-notebook

FROM $baseimg

#power8
ARG appdef=AppDef.json
ARG sample=9-2
        
RUN curl -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/nimbix/image-common/master/install-nimbix.sh | bash

COPY url.txt /etc/NAE/url.txt
COPY help.html /etc/NAE/help.html
COPY $appdef /etc/NAE/AppDef.json
RUN wget --post-file=/etc/NAE/AppDef.json --no-verbose https://api.jarvice.com/jarvice/validate -O -

# Expose port 22 for local JARVICE emulation in docker
EXPOSE 22
