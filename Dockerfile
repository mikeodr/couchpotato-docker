FROM phusion/baseimage:0.9.17
MAINTAINER Specter <mike@mikeodriscoll.ca>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

CMD ["/sbin/my_init"]

RUN usermod -u 99 nobody
RUN usermod -g 100 nobody

RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe multiverse"
RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates universe multiverse"
RUN apt-get update -qq
RUN apt-get upgrade -qq

# Install Dependencies
RUN apt-get install -qq -y git python python-cheetah ca-certificates


# Install SickBeard
RUN mkdir /opt/couchpotato
RUN git clone https://github.com/RuudBurger/CouchPotatoServer.git -b master /opt/couchpotato
RUN chown -R nobody:users /opt/couchpotato

EXPOSE 5050

# Couchpotato Configuration
VOLUME /config

# TV directory
VOLUME /movies

# Add couchpotato to runit
RUN mkdir /etc/service/couchpotato
ADD init/couchpotato.sh /etc/service/couchpotato/run
RUN chmod +x /etc/service/couchpotato/run
