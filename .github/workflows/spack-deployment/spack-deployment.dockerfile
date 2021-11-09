# Dockerfile to automatically publish the latest tagged version of gchp to spack
# For testing build with `docker build -f spack-deployment.dockerfile .`
FROM laestrada/conda-spack-environment:1.0.0
ARG version_tag
ARG gh_access_token
ENV TOKEN=$gh_access_token
ENV VERSION_TAG=$version_tag
# set env variables
ENV VERSION_TAG=13.2.1

# Make RUN commands use conda environment
SHELL ["conda", "run", "-n", "spackenv", "/bin/bash", "-c"]

# clone needed repos
RUN git clone https://github.com/geoschem/GCHP.git

COPY spack-packaging.sh ./spack-packaging.sh
RUN chmod +x spack-packaging.sh
RUN ./spack-packaging.sh

