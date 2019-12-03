FROM centos:8
MAINTAINER iwasaki <yuiwasaki@loadoff.jp>

RUN yum -y upgrade
RUN yum -y update
RUN yum install -y epel-release \
		golang \
		git
RUN rm -rf /var/cache/yum/* \
		&& yum clean all

RUN mkdir /go

ENV GOROOT /usr/lib/golang
ENV GOPATH /go
ENV PATH $PATH:$GOPATH/bin

RUN echo $PATH
RUN go get -u github.com/golang/dep/cmd/dep
RUN go get -u github.com/loadoff/apitest
WORKDIR $GOPATH/src/github.com/loadoff/apitest

RUN dep ensure
RUN go build main.go
EXPOSE 80

CMD ./main


