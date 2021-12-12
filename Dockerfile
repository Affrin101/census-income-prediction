# Docker file for the census income prediction
# Author: Philson
# December 09, 2021



FROM rocker/tidyverse

# Install python
RUN apt-get update && apt-get install -y python3 python3-pip


# install libxt6
RUN apt-get install -y --no-install-recommends libxt6
	
# Install R (Version 4.1.2)
RUN apt-get install r-base r-base-dev -y 
	
# Install required packages in R
RUN Rscript -e “install.packages(‘tidyverse’);”

# install the kableExtra package 
RUN Rscript -e "install.packages('kableExtra')"

# install knitr
RUN Rscript -e "install.packages('knitr', dependencies = TRUE)"


# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put miniconda in path so we can use conda
ENV PATH=$CONDA_DIR/bin:$PATH


RUN conda install --quiet -y -c conda-forge \
    “ipykernel=6.5.*” \
    “vega_datasets==0.9.*” \
    “graphviz==0.19” \
    “requests>=2.24.0" \
    “imbalanced-learn==0.8.*” \
    “altair==4.1.*” \
    “docopt==0.6.*” \
    “matplotlib==3.5.*” \
    “matplotlib-inline==0.1.*” \
    “numpy==1.21.*” \
    “pandas==1.3.*” \
    “scikit-learn==1.*” \
    “scipy==1.7.*” \
    “pandoc>=1.12.3" \

	


RUN pip install \
    “shap>=0.40.0"
	
RUN pip install altair-saver

RUN pip install altair_data_server
