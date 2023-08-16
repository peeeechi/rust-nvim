FROM ubuntu:20.04

ARG USER_NAME=inoue
ARG GROUP_NAME=${USER_NAME}
ARG UID=1000
ARG GID=${UID}
ARG PASS=${USER_NAME}
ARG DISPLAY=:1

ENV USER_NAME=${USER_NAME}
ENV GROUP_NAME=${GROUP_NAME}
ENV UID=${UID}
ENV GID=${GID}
ENV DISPLAY=${DISPLAY}

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  # utills
  gosu \
  sudo \
  git \
  curl \
  wget \
  # need gcc or build-essential to run builds with rust 
  build-essential \
  gcc \
  mingw-w64 \
  # clean up apt 
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# # Rust install
ENV RUST_HOME /usr/local/lib/rust
ENV RUSTUP_HOME ${RUST_HOME}/rustup
ENV CARGO_HOME ${RUST_HOME}/cargo

RUN mkdir ${RUST_HOME} \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > ${RUST_HOME}/rustup.sh \
    && chmod +x ${RUST_HOME}/rustup.sh \
    && ${RUST_HOME}/rustup.sh -y --default-toolchain stable --no-modify-path

ENV PATH $CARGO_HOME/bin:$PATH

  # rust-analysis \
RUN rustup component add \
  rustfmt \
  rls \
  rust-src \
  rust-analyzer \
  && rustup target add \
  x86_64-pc-windows-gnu \
  && chmod -R 0777 $RUST_HOME

# 日本語設定
ENV LANG ja_JP.UTF-8
RUN apt-get update && apt-get install -y --no-install-recommends \
  language-pack-ja-base \
  language-pack-ja \
  fonts-ipafont-gothic \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
  
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  # utills
  fzf \
  zip \
  xclip \
  unzip \
  fontconfig \
  # for vim-vimrc-coc
  && curl -sL https://deb.nodesource.com/setup_14.x  | bash - \
  && apt-get install nodejs \
  # download neovim image
  && curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
  && chmod +x nvim.appimage \
  && ./nvim.appimage --appimage-extract \
  && ln -s /squashfs-root/AppRun /usr/bin/nvim \
  # clean up apt 
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# CREATE USER
RUN groupadd -g ${GID} ${GROUP_NAME} \
  && useradd -m -s /bin/bash -u ${UID} -g ${GID} ${USER_NAME} \
  && echo "${USER_NAME}:${PASS}" | chpasswd \
  && usermod -G sudo ${USER_NAME} \
  # install Nerd font
  && mkdir -p /home/${USER_NAME}/.local/share/fonts \
  && curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/JetBrainsMono.zip \
  && unzip JetBrainsMono.zip -d /home/${USER_NAME}/.local/share/fonts/ \
  && fc-cache /home/${USER_NAME}/.local/share/fonts/ \
  && chown -R ${USER_NAME}:${GROUP_NAME} /home/${USER_NAME}

COPY ./scripts/* /tmp/
ENTRYPOINT [ "/tmp/init.sh" ]
CMD [ "/bin/bash" ]
