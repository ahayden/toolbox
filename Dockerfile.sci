ARG source_repo
FROM ${source_repo}:dev

ARG container_user
RUN test -n "${container_user}"

USER root

RUN apt-get update -qq -y && apt-get install --no-install-recommends -qq -y \
        r-base texlive texlive-latex-extra lmodern \
    && apt-get -y autoclean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install sympy numpy matplotlib statsmodels

USER ${container_user}

