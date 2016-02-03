FROM ubuntu:14.04

MAINTAINER Dmitriy Belyaev "dimabelyaev27@gmail.com"

RUN apt-get -y update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy \
    python-software-properties software-properties-common

RUN DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:nginx/stable

RUN DEBIAN_FRONTEND=noninteractive apt-get -qy update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install nginx=1.8.* nano dpkg-dev

RUN mkdir -p /opt/nginx
    
ADD nginx-full_1.8.1-1+trusty0_amd64.deb /opt/nginx/nginx-full_1.8.1-1+trusty0_amd64.deb

RUN DEBIAN_FRONTEND=noninteractive dpkg --install /opt/nginx/nginx-full_1.8.1-1+trusty0_amd64.deb && \
    /usr/sbin/update-rc.d -f nginx defaults

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
