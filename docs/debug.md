# Debugging

## Things to Check

* RAM utilization -- axed is very hungry and typically needs in excess of 1GB.  A swap file might be necessary.
* Disk utilization -- The axe blockchain will continue growing and growing and growing.  Then it will grow some more.  At the time of writing, 2GB+ is necessary.

## Viewing axed Logs

    docker logs axed-node


## Running Bash in Docker Container

*Note:* This container will be run in the same way as the axed node, but will not connect to already running containers or processes.

    docker run -v axed-data:/axe --rm -it axerunners/axed bash -l

You can also attach bash into running container to debug running axed

    docker exec -it axed-node bash -l
