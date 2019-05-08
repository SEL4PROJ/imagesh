######################################
### Permanent changes to container ###
######################################

# To make permanent changes to the container environment,
# you can edit this file, which uses the Dockerfile format.

# To add software, use the existing 'apt-get' block at the 
# bottom of this file


###################################
# Boilerplate
ARG USER_BASE_IMG
FROM $USER_BASE_IMG

RUN mkdir -p /etc/sudoers.d \
    && echo "%sudo   ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/nopasswd
# Boilerplate
###################################


###################################
# apt-get block

RUN dpkg --clear-avail \
    && rm -r /var/lib/apt/lists/* \
    && apt-get update -q \
    && apt-get install -y --no-install-recommends \
        # Add more dependencies here
        cowsay \
	sudo \
        vim \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

# apt-get block
###################################
