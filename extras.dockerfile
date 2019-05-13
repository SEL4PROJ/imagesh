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

ARG UID
ARG USER

RUN rm -r /var/lib/apt/lists/* \
    && dpkg --clear-avail \
    && apt-get update -q \
    && apt-get install -y --no-install-recommends \
	sudo \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && useradd -u ${UID} -G sudo ${USER} \
    && passwd -d ${USER} \
    # Always present the warning when using sudo
    && echo 'Defaults        lecture_file = /etc/sudoers.lecture' >> /etc/sudoers \
    && echo 'Defaults        lecture = always' >> /etc/sudoers \
    && echo 'Defaults        timestamp_timeout=0' >> /etc/sudoers \
    && echo '##################### Warning! #####################################' > /etc/sudoers.lecture \
    && echo 'This is an ephemeral container! You can do things to it using sudo, ' >> /etc/sudoers.lecture \
    && echo 'but when you exit, changes made outside of your home directory will ' >> /etc/sudoers.lecture \
    && echo 'be lost.' >> /etc/sudoers.lecture \
    && echo 'If you want your changes to be permanent, add them to the ' >> /etc/sudoers.lecture \
    && echo '    /etc/imagesh/extras.dockerfile' >> /etc/sudoers.lecture \
    && echo '####################################################################' >> /etc/sudoers.lecture \
    && echo '' >> /etc/sudoers.lecture 
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
        vim \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

# apt-get block
###################################
