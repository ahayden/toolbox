ARG source_repo
FROM ${source_repo}:dev

ARG container_user
RUN test -n "${container_user}"

USER root

RUN apt-get update -qq -y && apt-get install --no-install-recommends -qq -y \
        texlive texlive-plain-generic texlive-latex-extra texlive-xetex \ 
	lmodern librsvg2-bin aspell fonts-freefont-ttf r-base tini \
    && apt-get -y autoclean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install sympy scipy numpy matplotlib statsmodels jupyter

USER ${container_user}

ENTRYPOINT ["tini", "--"]

CMD jupyter lab --port=8888 --no-browser --ip=0.0.0.0 --LabApp.token='' --LabApp.password='' --notebook-dir=src 


