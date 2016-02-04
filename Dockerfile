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

RUN mkdir -p /opt/rebuildnginx && mkdir /opt/upload-module && mkdir /opt/upload-progress-module

RUN cd /opt/upload-module && wget https://github.com/vkholodkov/nginx-upload-module/archive/2.2.zip && unzip 2.2.zip

RUN cd /opt/upload-progress-module && wget https://github.com/masterzen/nginx-upload-progress-module/archive/master.zip && unzip master.zip

WORKDIR /opt/rebuildnginx

ADD configure.py .

RUN apt-get -y source nginx && apt-get -y build-dep nginx

RUN cd $(find -maxdepth 1 -type d -name '*nginx*'| head -n1) && cd debian/ && \
    python /opt/rebuildnginx/configure.py -i rules && cd ../ && dpkg-buildpackage -b

RUN dpkg --install $(find -maxdepth 1 -name 'nginx-full_*'| head -n1) && /usr/sbin/update-rc.d -f nginx defaults

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
