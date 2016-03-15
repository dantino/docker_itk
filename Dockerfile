# ITK
#
# VERSION               4.9.0
FROM gliderlabs/alpine
MAINTAINER Dante De Nigris <dante.denigris@gmail.com>
LABEL Description="Includes ITK toolkit" Vendor="Dantino" Version="4.9.0"

RUN apk --update add ca-certificates
RUN apk add tzdata
RUN apk add alpine-sdk
RUN apk add cmake
RUN apk add clang


RUN mkdir -p /var/repos
RUN mkdir -p /var/builds/itk

WORKDIR /var/repos

RUN git clone -b 4.9.0_alpine --depth=1 https://github.com/dantino/ITK.git itk

WORKDIR /var/builds/itk

ENV CC /usr/bin/clang
ENV CXX /usr/bin/clang++
RUN cmake -DBUILD_TESTING:BOOL=OFF -DUSE_REVIEW:BOOL=ON -DCMAKE_BUILD_TYPE:STRING=Release /var/repos/itk
RUN make && make install
RUN rm -rf /var/builds/itk
RUN rm -rf /var/repos/itk
