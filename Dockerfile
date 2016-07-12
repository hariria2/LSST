FROM ubuntu:14.04
MAINTAINER Sahand Hariri


# update, wget and git
RUN apt-get -y update && apt-get install -y \
wget \
git \
vim


# Java
RUN apt-get install -y \
default-jre \
default-jdk


# Python
#RUN apt-get install python-pip
#RUN pip install --upgrade pip
#RUN pip install --upgrade virtualenv
#RUN pip install \
#pandas \
#"ipython[notebook]"


# Scala
RUN wget http://www.scala-lang.org/files/archive/scala-2.11.8.deb
RUN dpkg -i scala-2.11.8.deb

# get Spark
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-1.6.1-bin-hadoop2.6.tgz
RUN tar -zxf spark-1.6.1-bin-hadoop2.6.tgz
RUN cp /spark-1.6.1-bin-hadoop2.6/conf/log4j.properties.template /spark-1.6.1-bin-hadoop2.6/conf/log4j.properties
RUN sed -i 's/log4j.rootCategory=INFO/log4j.rootCategory=WARN/g' /spark-1.6.1-bin-hadoop2.6/conf/log4j.properties
RUN cd && sudo mv spark-* /usr/local/spark
RUN cd && export SPARK_HOME=/usr/local/spark && export SPARK_LOCAL_IP="127.0.0.1" &&export PATH=$PATH:$SPARK_HOME/bin
RUN echo export SPARK_HOME=/usr/local/spark >> ~/.profile && echo export SPARK_LOCAL_IP="127.0.0.1" >> ~/.profile && echo export PATH=$PATH:$SPARK_HOME/bin >> ~/.profile
RUN sudo chown -R ubuntu $SPARK_HOME
