# ITK
#
# VERSION               4.9.0
FROM gliderlabs/alpine
MAINTAINER Dante De Nigris <dante.denigris@gmail.com>
LABEL Description="Includes ITK toolkit" Vendor="Dantino" Version="4.9.0"

RUN apk --update add ca-certificates

ENV CC /usr/bin/clang
ENV CXX /usr/bin/clang++

RUN \
     apk add tzdata alpine-sdk cmake clang && \
     mkdir -p /var/repos && mkdir -p /var/builds/itk && cd /var/repos && \
     git clone -b 4.9.0_alpine --depth=1 https://github.com/dantino/ITK.git itk && \
     cd /var/builds/itk && \
     cmake -DBUILD_TESTING:BOOL=OFF -DUSE_REVIEW:BOOL=ON -DCMAKE_BUILD_TYPE:STRING=Release /var/repos/itk && \
     make -j 8 && make install && rm -rf var/builds/itk && rm -rf /var/repos/itk && \
     apk del --purge tzdata apline-sdk cmake clang 

