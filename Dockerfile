FROM amazonlinux:latest
RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash - && \
    curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
RUN yum -y update && \
    yum -y install \
    git bzip2 tar gcc gcc-c++ make openssl-devel readline-devel zlib-devel mysql-devel nodejs yarn &&\
    rm -rf /var/cache/yum/*
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv && \
    git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build && \
    /root/.rbenv/plugins/ruby-build/install.sh && \
    echo 'export PATH=$PATH' >> /root/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> /root/.bashrc
ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH
RUN rbenv install 2.7.1 && \
    rbenv global 2.7.1 && \
    rbenv exec gem install bundler
WORKDIR /test_app
