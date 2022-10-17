FROM ruby:3.1.2
LABEL maintainer "Afonsinho"

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV BUNDLER_VERSION=2.3.22
ENV NODE_VERSION=14.20.0

RUN apt-get update -qq && apt-get install -y sudo curl build-essential ca-certificates \
    git gzip imagemagick libc6 libgmp-dev libncurses6 libreadline-dev libreadline7 \
    libssl-dev libssl1.1 libtinfo6 libxml2-dev libxslt1-dev pkg-config procps tar \
    shared-mime-info unzip zlib1g zlib1g-dev postgresql-client libpq-dev

RUN gem install bundler --version $BUNDLER_VERSION

RUN sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS    90/' /etc/login.defs && \
    sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS    0/' /etc/login.defs && \
    sed -i 's/sha512/sha512 minlen=8/' /etc/pam.d/common-password

RUN adduser --disabled-password --gecos '' afon && \
    adduser afon sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    usermod -u 1000 afon

RUN mkdir /app && chown afon: /app

USER afon

RUN bash -c "$(curl -L https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)" -- \
    -t https://github.com/denysdovhan/spaceship-prompt \
    -a 'SPACESHIP_PROMPT_ADD_NEWLINE="false"' \
    -a 'SPACESHIP_CHAR_SYMBOL="👾 "' \
    -p git \
    -p https://github.com/zdharma-continuum/fast-syntax-highlighting \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions

COPY .docker/entrypoint.sh /usr/bin/
RUN sudo chmod +x /usr/bin/entrypoint.sh

WORKDIR /app

COPY Gemfile* ./
COPY package* ./

RUN bundle config set force_ruby_platform true
RUN bundle install && yarn install

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]
CMD ["tail", "-f"]