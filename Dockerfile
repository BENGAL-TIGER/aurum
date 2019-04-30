
FROM rocker/binder:3.5.3

USER root

## Copies your repo files into the Docker Container
add . ${HOME}
RUN cat splash && printf "Beginning installation...\n\n\n" \
 && chown -R ${NB_USER} ${HOME}
 # && mkdir ${HOME}/work

# run mkdir ${COOLPROP_BINARIES}
# run mkdir ${HOME}/work

# add CoolProp.sources ${HOME}/CoolProp.sources/

# add CoolProp621 ${COOLPROP_BINARIES}/
# add CoolProp621linux ${HOME}/
# RUN chown -R ${NB_USER} ${COOLPROP_BINARIES}
# RUN chown -R ${NB_USER} ${HOME}
# RUN chown -R ${NB_USER} /opt
#
run apt-get update && apt-get install -y \
    cmake \
    git \
    g++ \
    p7zip \
    libpython-dev \
    swig \
 && cat splash \
 && printf "Core routines installed...\n\n\n"


# _____ lifted from rocker-org/rocker/r-base/Dockerfile ____________________
ENV R_BASE_VERSION 3.5.3

# ## Now install R and littler, and create a link for littler in /usr/local/bin
# RUN apt-get update -y \
#  && apt-get install  -y --no-install-recommends \
#     littler \
#     r-cran-littler \
# 	# r-base=${R_BASE_VERSION}-* \
# 	# r-base-dev=${R_BASE_VERSION}-* \
# 	# r-recommended=${R_BASE_VERSION}-* \
#  && ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r \
#  # && ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r \
#  # && ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
#  && ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
#  && install.r docopt \
#  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
#  && rm -rf /var/lib/apt/lists/* \
#  && cat splash \
#  && printf "R installed...\n\n\n"
# # _____ end rocker/r-base/ _________________________________________________




# _____ miniconda __________________________________________________________
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh -O ~/miniconda.sh \
 && /bin/bash ~/miniconda.sh -b -p /opt/conda \
 && rm ~/miniconda.sh \
 && /opt/conda/bin/conda clean -tipsy \
 && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
 && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc \
 && echo "conda activate base" >> ~/.bashrc \
 && cat splash \
 && printf "miniconda installed...\n\n\n"

# run pip install six
#
#  # Check out the sources for CoolProp
#  run git clone https://github.com/CoolProp/CoolProp --recursive
#  # Move into the folder you just created
#  run mkdir -p  CoolProp/build && cd CoolProp/build
#  # Build the makefile using CMake
#  run cmake .. -DCOOLPROP_R_MODULE=ON -DR_BIN="/usr/bin" -DCMAKE_BUILD_TYPE=Release
#  # Make the R shared library
#  run cmake --build .


# _____ julia ______________________________________________________________
ENV JULIA_VERSION=1.1.0

RUN mkdir /opt/julia-${JULIA_VERSION} \
 && cd /tmp \
 && wget -q https://julialang-s3.julialang.org/bin/linux/x64/`echo ${JULIA_VERSION} | cut -d. -f 1,2`/julia-${JULIA_VERSION}-linux-x86_64.tar.gz \
 && echo "80cfd013e526b5145ec3254920afd89bb459f1db7a2a3f21849125af20c05471 *julia-${JULIA_VERSION}-linux-x86_64.tar.gz" | sha256sum -c - \
 && tar xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz -C /opt/julia-${JULIA_VERSION} --strip-components=1 \
 && rm /tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz \
 && ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia \
 && cd ~ \
 && cat splash \
 && julia -e 'print("Julia v",VERSION," installed...\n\n\n")'


## Become normal user again
USER ${NB_USER}


# # _____ r packages _________________________________________________________
# run install2.r --error --deps TRUE \
#     tidyverse \
#     devtools \
#     formatR \
#     remotes \
#     caTools \
#     reticulate \
#     # RColorBrewer \
#     reticulate \
#     rmarkdown \
#     caTools \
#     bitops \
#     shiny \
#     ggthemes \
#     ggrepel \
#     tufte \
# #
#  && R -e "devtools::install_github(c( \
#      'rstudio/bookdown', \
#      'pzhaonet/bookdownplus' \
#      ))" \
#  && cat splash \
#  && printf "R packages installed...\n\n\n"

# _____ julia packages _____________________________________________________
# RUN julia -e 'import Pkg; Pkg.update()' \
 # && julia -e 'using Pkg; pkg"add Gadfly RDatasets InstantiateFromURL"; pkg"precompile" ' && \
#  && julia -e 'import Pkg; Pkg.add("HDF5")')  \
#  && julia -e 'import Pkg; Pkg.add("Gadfly")'  \
#  && julia -e 'import Pkg; Pkg.add("RDatasets")'  \
#  && julia -e 'import Pkg; Pkg.add("ZMQ")'  \
#  && julia -e 'import Pkg; Pkg.add("Compat")'  \
#  && julia -e 'import Pkg; Pkg.add("DataStructures")' \
#  && julia -e 'import Pkg; Pkg.add("DataFrames")' \
#  && julia -e 'import Pkg; Pkg.add("LightXML")' \
 # && julia -e 'import Pkg; Pkg.add("Unitful")' \
#  && julia -e 'import Pkg; Pkg.add("CSV")' \
#  && julia -e 'import Pkg; Pkg.add("Random")'
#
# run julia -e 'import Pkg; Pkg.clone("https://github.com/OpenModelica/OMJulia.jl"); Pkg.resolve(); Pkg.update(); using OMJulia'  \
 # && julia -e "import Pkg; Pkg.add(\"IJulia\") " \
 #  Precompile Julia packages \
 # && julia -e "using IJulia" \

run julia -e 'using Pkg; \
              pkg"add Unitful \
                      IJulia \
                      InstantiateFromURL"; \
              pkg"precompile" ' \
 && cat splash \
 && printf "Julia packages installed... \n\n\n"



## Run an install.R script, if it exists.
# RUN if [ -f install.R ]; then R --quiet -f install.R; fi
# RUN if [ -f install.R ]; then R  -f install.R; fi

# ENTRYPOINT ["/bin/bash", "-c", "cat splash; jupyter notebook"]

# CMD []

env SHELL=/bin/bash
    # HOME=${HOME}/work

workdir ${HOME}/work
