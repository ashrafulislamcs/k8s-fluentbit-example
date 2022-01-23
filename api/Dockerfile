FROM elixir:1.12.3

RUN mix local.hex --force \
  && mix archive.install hex phx_new \
  && apt-get update \
  && curl -sL https://deb.nodesource.com/setup_12.x | bash \
  && apt-get install -y apt-utils \
  && apt-get install -y nodejs \
  && apt-get install -y build-essential \
  && apt-get install -y inotify-tools \
  && mix local.rebar --force

WORKDIR /app

COPY . .

EXPOSE 4000