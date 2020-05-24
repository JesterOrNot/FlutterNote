FROM gitpod/workspace-flutter

USER gitpod

RUN sudo add-apt-repository ppa:maarten-fonville/android-studio \
    && sudo apt-get update -qq \
    && sudo apt-get install -yq --no-install-recommends \
        android-sdk \
        lib32stdc++6 \
        android-studio \
        android-sdk-build-tools \
        android-sdk \
        android-sdk-platform-23 \
    && sudo rm -rf /var/lib/apt/lists/*
