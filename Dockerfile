FROM rust:slim-bookworm AS builder

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    libssl-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN rustup install nightly-2026-01-18 && rustup default nightly-2026-01-18

# RUN git clone https://github.com/facebook/buck2.git /src
COPY . ./src


WORKDIR src

RUN cargo install --path=app/buck2 --root /usr/local

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    ca-certificates \
    clang \
    lld \
    libssl3 \
    tini \
    && rm -rf /var/lib/apt/lists/*

ENV HOME=/root

COPY --from=builder /usr/local/bin/buck2 /usr/local/bin/buck2
COPY --from=builder /usr/local/rustup /usr/local/rustup
COPY --from=builder /usr/local/cargo /usr/local/cargo
ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo
ENV PATH="/usr/local/cargo/bin:${PATH}"
# COPY --from=builder examples ./src
WORKDIR examples/with_prelude


ENTRYPOINT ["tini", "--", "buck2"]
