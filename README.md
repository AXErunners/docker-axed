axed for Docker
================

[![Docker Stats](http://dockeri.co/image/axerunners/axed)](https://hub.docker.com/r/axerunners/axed/)

[![Build Status](https://travis-ci.org/AXErunners/docker-axed.svg?branch=master)](https://travis-ci.org/AXErunners/docker-axed/)

Docker image that runs the axed node in a container for easy deployment.


Requirements
------------

* Physical machine, cloud instance, or VPS that supports Docker (i.e. [Vultr](https://www.vultr.com/?ref=7231821), Digital Ocean, KVM or XEN based VMs) running Ubuntu 14.04 or later (*not OpenVZ containers!*)
* At least 4 GB to store the block chain files
* At least 1 GB RAM + 2 GB swap file

Recommended and tested on Vultr 1024 MB RAM/320 GB disk instance @ $8/mo.  Vultr also *accepts Bitcoin payments*!  May run on the 512 MB instance, but took *forever* (1+ week) to initialize due to swap and disk thrashing.


Really Fast Quick Start
-----------------------

One liner for Ubuntu 14.04 LTS machines with JSON-RPC enabled on localhost and adds upstart init script:

    curl https://raw.githubusercontent.com/axerunners/docker-axed/master/bootstrap-host.sh | sh -s trusty


Quick Start
-----------

1. Create a `axed-data` volume to persist the axed blockchain data, should exit immediately.  The `axed-data` container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):

        docker volume create --name=axed-data
        docker run -v axed-data:/axe --name=axed-node -d \
            -p 9937:9937 \
            -p 127.0.0.1:9337:9337 \
            axerunners/axed

2. Verify that the container is running and axed node is downloading the blockchain

        $ docker ps
        CONTAINER ID        IMAGE                         COMMAND             CREATED             STATUS              PORTS                                              NAMES
        d0e1076b2dca        axerunners/axed:latest          "axe_oneshot"      2 seconds ago       Up 1 seconds        127.0.0.1:9337->9337/tcp, 0.0.0.0:9937->9937/tcp   axed-node

3. You can then access the daemon's output thanks to the [docker logs command]( https://docs.docker.com/reference/commandline/cli/#logs)

        docker logs -f axed-node

4. Install optional init scripts for upstart and systemd are in the `init` directory.


Documentation
-------------

* To run in testnet, add environment variable `TESTNET=1` to `docker run` as such:

        docker run -v axed-data:/axe --name=axed-node -d \
            --env TESTNET=1 \
            -p 9937:9937 \
            -p 127.0.0.1:9337:9337 \
            axerunners/axed

* Additional documentation in the [docs folder](docs).

Credits
-------

Original work by Kyle Manna [https://github.com/kylemanna/docker-bitcoind](https://github.com/kylemanna/docker-bitcoind).
Modified to use AXE Core instead of Bitcoin Core.
