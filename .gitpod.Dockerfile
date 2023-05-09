FROM gitpod/workspace-full

USER gitpod

# Install Flutter
RUN wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_2.5.3-stable.tar.xz \
    && tar -xvf flutter_linux_2.5.3-stable.tar.xz \
    && rm flutter_linux_2.5.3-stable.tar.xz

# Add Flutter to the PATH
ENV PATH="/workspace/flutter/bin:$PATH"
