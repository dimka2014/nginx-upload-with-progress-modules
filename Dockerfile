FROM ubuntu:14.04

MAINTAINER Dmitriy Belyaev "dimabelyaev27@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update

RUN apt-get install -qy \
    python-software-properties software-properties-common

RUN add-apt-repository -y ppa:nginx/stable

RUN apt-get -qy update

RUN apt-get -y install nginx=1.8.* nano dpkg-dev

RUN mkdir -p /opt/nginx
    
ADD nginx-full_1.8.1-1+trusty0_amd64.deb /opt/nginx/nginx-full_1.8.1-1+trusty0_amd64.deb

RUN dpkg --install /opt/nginx/nginx-full_1.8.1-1+trusty0_amd64.deb && \
    /usr/sbin/update-rc.d -f nginx defaults

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
