FROM ubuntu:19.10

ENV HOME /root

# no ncurses prompts
ENV DEBIAN_FRONTEND noninteractive

# update packages and install tools 
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends \
    curl \
    openjdk-8-jdk-headless \
    git \
    gnupg2

# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn -y

# install clojure/script
RUN curl -O https://download.clojure.org/install/linux-install-1.10.1.502.sh
RUN chmod +x linux-install-1.10.1.502.sh
RUN ./linux-install-1.10.1.502.sh

# build project
RUN git clone https://github.com/roman01la/proton-native-cljs

WORKDIR proton-native-cljs
RUN yarn
RUN yarn build

RUN ls -lah
