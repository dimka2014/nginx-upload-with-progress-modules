FROM ubuntu:14.04

MAINTAINER Dmitriy Belyaev "dimabelyaev27@gmail.com"

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm

RUN apt-get -y update

RUN apt-get install -qy \
    python-software-properties software-properties-common

RUN add-apt-repository -y ppa:nginx/stable

RUN apt-get -qy update

RUN apt-get -y install nginx=1.8.* nano dpkg-dev wget unzip

RUN sed -i -e 's/# //' /etc/apt/sources.list.d/nginx-stable-trusty.list

RUN apt-get -y update

RUN mkdir -p /opt/rebuildnginx && cd /opt/rebuildnginx && \
    apt-get -y source nginx && apt-get -y build-dep nginx

RUN mkdir /opt/upload-module && cd /opt/upload-module && \ 
    wget https://github.com/vkholodkov/nginx-upload-module/archive/2.2.zip && unzip 2.2.zip
    
RUN mkdir /opt/upload-progress-module && cd /opt/upload-progress-module && \
    wget https://github.com/masterzen/nginx-upload-progress-module/archive/master.zip && unzip master.zip