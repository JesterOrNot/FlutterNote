FROM gitpod/workspace-flutter

USER gitpod

RUN cd /usr/lib \
    && sudo mkdir android-sdk \
    && sudo wget https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip \
    && sudo unzip -d android-sdk -q commandlinetools-linux-6200805_latest.zip \
    && sudo rm *.zip

RUN sudo chmod -R 777 ${ANDROID_HOME}

ENV PATH=${PATH}:${ANDROID_HOME}

RUN flutter upgrade
