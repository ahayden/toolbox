ARG source_repo
FROM ${source_repo}:tex

ARG container_user
RUN test -n "${container_user}"

USER root

RUN apt-get update -qq -y && apt-get install --no-install-recommends -qq -y \
        r-base \
    && apt-get -y autoclean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install sympy scipy numpy matplotlib statsmodels

USER ${container_user}

