FROM gitpod/workspace-flutter

USER gitpod

RUN sudo add-apt-repository ppa:maarten-fonville/android-studio \
    && sudo apt-get update -qq \
    && sudo apt-get install -yq \
        android-sdk \
        zip \
        unzip \
        lib32stdc++6 \
        android-studio \
        android-sdk-build-tools \
    && sudo rm -rf /var/lib/apt/lists/*

RUN cd /usr/lib \
    && sudo wget https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip \
    && sudo unzip -n -d android-sdk -q commandlinetools-linux-6200805_latest.zip \
    && sudo rm *.zip
ENV ANDROID_HOME=/usr/lib/android-sdk
RUN sudo chmod -R 777 ${ANDROID_HOME}
ENV PATH=${PATH}:${ANDROID_HOME}/tools/bin
