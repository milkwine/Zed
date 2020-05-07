FROM ubuntu:focal

RUN apt-get update 

RUN apt-get install -y libanyevent-perl libdata-printer-perl libfile-spec-native-perl libmodule-runtime-perl libnet-openssh-perl libpath-tiny-perl libterm-readline-gnu-perl libterm-readpassword-perl libyaml-libyaml-perl libio-pty-perl

COPY . /Zed

CMD [ "perl", "-I", "/Zed/lib/", "/Zed/script/zed"]
