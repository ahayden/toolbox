ARG source_repo
FROM ${source_repo}:dev

ARG container_user
RUN test -n "${container_user}"

USER root

RUN apt-get update -qq -y && apt-get install --no-install-recommends -qq -y \
        texlive texlive-plain-generic texlive-latex-extra texlive-xetex \ 
	lmodern pandoc librsvg2-bin aspell fonts-freefont-ttf \
        r-base tini jupyter-notebook \
    && apt-get -y autoclean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install sympy scipy numpy matplotlib statsmodels

USER ${container_user}

ENTRYPOINT ["tini", "--"]

CMD jupyter notebook --port=8888 --no-browser --ip=0.0.0.0 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.notebook_dir=src


