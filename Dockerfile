FROM amazonlinux:1

ADD ./config/.bash_profile /root/
ADD ./config/.bashrc /root/

RUN yum -y update && yum install -y sudo \
&& sudo yum install -y gcc gcc-c++ make git openssl-devel bzip2-devel zlib-devel readline-devel sqlite-devel \
&& sudo git clone https://github.com/yyuu/pyenv.git /usr/bin/.pyenv \
&& cd /usr/bin/.pyenv \
&& sudo mkdir shims versions \
&& sudo yum -y install libffi-devel \
&& source ~/.bashrc \
&& sudo plugins/python-build/install.sh \
&& /usr/bin/.pyenv/bin/pyenv install 3.7.1 \
&& pyenv local 3.7.1 \
&& pyenv global system 3.7.1 \
&& pip install -U pip \
&& source ~/.bash_profile \
&& sudo mkdir /var/task \
&& sudo ln -s /usr/libexec/gcc/x86_64-amazon-linux/4.8.5/cc1plus /usr/local/bin/ \
&& cd ~ \
&& curl -L "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE" -o mecab-0.996.tar.gz \
&& tar -zxvf mecab-0.996.tar.gz \
&& cd mecab-0.996 \
&& sudo ./configure --prefix=/var/task --with-charset=utf8 \
&& sudo make && sudo make install \
&& cd ~ \
&& curl -L "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM" -o mecab-ipadic-2.7.0-20070801.tar.gz \
&& tar -zxvf mecab-ipadic-2.7.0-20070801.tar.gz \
&& cd mecab-ipadic-2.7.0-20070801 \
&& sudo ./configure --prefix=/var/task --with-charset=utf8 --with-mecab-config=/var/task/bin/mecab-config \
&& sudo make && sudo make install \
&& cd ~ && mkdir temp && cd temp \
&& pip install mecab-python3 -t . \
&& mv ./* /var/task \
&& mkdir /var/task/dic \
&& sudo yum -y install zip