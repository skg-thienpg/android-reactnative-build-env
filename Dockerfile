FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y android-sdk
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip
RUN apt-get install -y unzip
RUN unzip commandlinetools-linux-8092744_latest.zip
RUN mkdir /usr/lib/android-sdk/cmdline-tools
RUN mkdir /usr/lib/android-sdk/cmdline-tools/latest
RUN mv -v cmdline-tools/* /usr/lib/android-sdk/cmdline-tools/latest/

#Export env
ENV ANDROID_HOME="/usr/lib/android-sdk" 
ENV PATH="$ANDROID_HOME/cmdline-tools/latest/bin/:$PATH"
ENV PATH="$ANDROID_HOME/emulator/:$PATH"
ENV PATH="$ANDROID_HOME/platform-tools/:$PATH"

#Setup android sdk
RUN yes | sdkmanager --licenses
RUN yes | sdkmanager --update
RUN sdkmanager "platform-tools" "platforms;android-29"

#install NODE
# RUN apt-get install -y nodejs npm
RUN apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - 
RUN apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install -y yarn
RUN echo yarn --version
CMD ["/bin/bash"]
