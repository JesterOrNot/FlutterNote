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
        android-sdk \
        android-sdk-platform-23 \
    && sudo rm -rf /var/lib/apt/lists/*

ENV ANDROID_HOME /opt/android-sdk-linux

RUN cd /opt && \
    sudo wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
    && sudo unzip -q *.zip -d ${ANDROID_HOME} \
    && sudo rm *.zip

RUN sudo chmod -R 777 ${ANDROID_HOME}
