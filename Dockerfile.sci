ARG source_repo
FROM ${source_repo}:dev

ARG container_user
RUN test -n "${container_user}"

USER root

RUN apt-get update -qq -y && apt-get install --no-install-recommends -qq -y \
        texlive texlive-plain-generic texlive-latex-extra texlive-xetex \ 
	lmodern librsvg2-bin aspell fonts-freefont-ttf tini julia nodejs \
    && apt-get -y autoclean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install sympy scipy numpy matplotlib statsmodels jupyterlab 

USER ${container_user}

RUN julia -e 'using Pkg; pkg"add IJulia SymPy Plots DifferentialEquations; precompile"'

ENTRYPOINT ["tini", "--"]

CMD JUPYTER_ENABLE_LAB=yes jupyter lab --port=8888 --no-browser --ip=0.0.0.0 \
    --ServerApp.token='' --ServerApp.password='' --notebook-dir=src 


