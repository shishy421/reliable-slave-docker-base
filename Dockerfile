FROM reliable-docker-base

MAINTAINER ssy<469894183@qq.com>

RUN yum install -y xorg-x11-server-Xvfb java-1.7.0-openjdk-devel which glibc.i686 zlib.i686 libgcc-4.8.5-4.el7.i686 glx-utils git libstdc++.i686 file make qemu-kvm libvirt virt-install bridge-utils

ENV JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk ANDROID_HOME=/usr/local/android-sdk-linux DISPLAY=:99.0
ENV PATH=$ANDROID_HOME/tools:$PATH

RUN curl -o android-sdk.tgz http://dl.gmirror.org/android/android-sdk_r24.4.1-linux.tgz && \
    tar -C /usr/local -xvf android-sdk.tgz

# sys-img-armeabi-v7a-android-22 sys-img-x86_64-android-22

RUN echo y | android update sdk --proxy-host mirrors.neusoft.edu.cn --proxy-port 80 -s --all --filter build-tools-22.0.1,android-22,sys-img-armeabi-v7a-android-22,platform-tool --no-ui --force

#apache-ant
ENV ANT_HOME=/usr/local/apache-ant-1.9.8
ENV PATH=$ANT_HOME/bin:$PATH
RUN curl -o apache-ant.tar.gz http://archive.apache.org/dist/ant/binaries/apache-ant-1.9.8-bin.tar.gz  && \
    tar -C /usr/local -zxvf apache-ant.tar.gz

#淘宝镜像
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org

#install macaca-cli
RUN npm install macaca-cli -g

#macaca依赖
RUN npm install macaca-chrome -g
#RUN cnpm install macaca-android -g
RUN npm install macaca-electron -g

#查看macaca环境
RUN macaca doctor

WORKDIR /

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
