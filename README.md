# ImageSh

Users have a shell inside a container image!

## How does it work

This uses rootless podman containers to redirect users into a container image.

It also maps in their nfshome dir as their home in the container.

## Setup

Clone this repo to /etc/imagesh

In /usr/local/bin, create a symlink to /etc/imagesh/bin/imagesh:

    cd /usr/local/bin && sudo ln -s /etc/imagesh/bin/imagesh imagesh

Now add the imagesh to the acceptable shells:

    sudo bash -c 'echo "/usr/local/bin/imagesh" >> /etc/shells'

Now add a user to the imagesh:

    sudo /etc/imagesh/bin/add_user.sh $their_user_name


# Note

This tool is used internally within Trustworthy Systems for testing and development. It may not be ready for production use, and also may have security issues. It's largely a useful prototype!

# TODO

- Convert all the podman commands to https://github.com/debarshiray/toolbox if possible
- Need a way to default back to bash if things go wrong 

# Credits

Inspired from:

- https://github.com/debarshiray/toolbox
- https://github.com/sleeepyjack/dockersh
