FROM registry.redhat.io/rhel8/podman:latest
ENV MOLECULE_NO_LOG false

USER root
RUN yum reinstall glibc-common -y
RUN yum update -y && yum install tar gcc make python3-pip zlib-devel openssl-devel yum-utils libffi-devel -y

ADD https://www.python.org/ftp/python/3.7.10/Python-3.7.10.tgz Python-3.7.10.tgz
RUN tar xf Python-3.7.10.tgz && cd Python-3.7.10/ && ./configure && make && make altinstall
ADD https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz Python-3.9.2.tgz
RUN tar xf Python-3.9.2.tgz && cd Python-3.9.2/ && ./configure && make && make altinstall
RUN python3 -m pip install --upgrade pip && pip3 install tox selinux
RUN sed -i 's/netns="host"/netns="private"/g' /etc/containers/containers.conf
RUN sed -i 's/utsns="host"/utsns="private"/g' /etc/containers/containers.conf
RUN rm -rf Python-*
#RUN pip3 install tox
#RUN pip3 install molecule
#RUN pip3 install "ansible-lint<6.0.0"
#RUN pip3 install molecule_podman
#RUN pip3 install flake8
#RUN yum install docker -y
#RUN pip3 install --no-cache-dir -U urllib3
