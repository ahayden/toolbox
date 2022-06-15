ARG source_repo
FROM ${source_repo}:dev

ARG container_user
RUN test -n "${container_user}"

USER root

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq -y && apt-get install --no-install-recommends -qq -y \
        tini julia nodejs r-cran-irkernel \
    && apt-get -y autoclean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install sympy scipy numpy astropy matplotlib statsmodels \ 
        jupyterlab scikit-learn scikit-image mahotas ipympl

USER ${container_user}

RUN julia -e 'using Pkg; pkg"add IJulia Pluto"'

ENTRYPOINT ["tini", "--"]

CMD JUPYTER_ENABLE_LAB=yes jupyter lab --port=8888 --no-browser --ip=0.0.0.0 \
    --ServerApp.token='' --ServerApp.password='' --notebook-dir=src 


