FROM ubuntu:14.04

MAINTAINER Dmitriy Belyaev "dimabelyaev27@gmail.com"

RUN mkdir -p /opt/rebuildnginx

ADD patch /opt/rebuildnginx/

RUN apt-get -qy update && apt-get install -qy python-software-properties software-properties-common && \
    add-apt-repository -y ppa:nginx/stable && sed -i -e 's/# //' /etc/apt/sources.list.d/nginx-stable-trusty.list && \
    apt-get -qy update && apt-get -qy install nginx=1.8.* nano dpkg-dev wget unzip && \
    mkdir /opt/upload-module && mkdir /opt/upload-progress-module && cd /opt/upload-module && \
    wget https://github.com/vkholodkov/nginx-upload-module/archive/2.2.zip && unzip 2.2.zip && \
    cd /opt/upload-progress-module && wget https://github.com/masterzen/nginx-upload-progress-module/archive/master.zip && \
    unzip master.zip && cd /opt/rebuildnginx && apt-get -y source nginx && apt-get -y build-dep nginx && \
    cd /opt/rebuildnginx && cd $(find -maxdepth 1 -type d -name '*nginx*'| head -n1)/debian/ && patch -p0 < ../../patch && \
    cd .. && dpkg-buildpackage -b && cd .. && dpkg --install $(find -maxdepth 1 -name 'nginx-full_*'| head -n1) && \
    /usr/sbin/update-rc.d -f nginx defaults && rm -rf /opt/rebuildnginx /opt/upload-module /opt/upload-progress-module     

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
