FROM elixir:1.20.4-otp-28 AS build

ENV MIX_ENV=prod

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN mix local.hex --force \
    && mix local.rebar --force

COPY mix.exs mix.lock ./
RUN mix deps.get --only prod
RUN mix deps.compile

COPY config config
COPY lib lib
COPY priv priv
COPY assets assets

RUN mix compile
RUN mix assets.deploy
RUN mix release

FROM elixir:1.20.4-otp-28 AS runtime

ENV MIX_ENV=prod \
    PHX_SERVER=true \
    LANG=C.UTF-8

WORKDIR /app

COPY --from=build /app/_build/prod/rel/todo ./

EXPOSE 4000

CMD ["bin/todo", "start"]