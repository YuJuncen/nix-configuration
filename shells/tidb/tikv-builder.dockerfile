FROM centos:7

RUN yum install -y epel-release && \
    yum clean all && \
    yum makecache

RUN yum install -y centos-release-scl && \
    yum install -y \
      devtoolset-8 \
      perl cmake3 && \
    yum clean all

# CentOS gives cmake 3 a weird binary name, so we link it to something more normal
# This is required by many build scripts, including ours.
RUN ln -s /usr/bin/cmake3 /usr/bin/cmake
ENV LIBRARY_PATH /usr/local/lib:$LIBRARY_PATH
ENV LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH

# Install Rustup
RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain none -y
ENV PATH /root/.cargo/bin/:$PATH

RUN source /opt/rh/devtoolset-8/enable
ENTRYPOINT [ "bash" ]