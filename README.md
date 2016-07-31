# docker-swarm-mode-vagrant

This project is to similify the setup for [Docker Swarm Mode][1] with Vagrant.

It will automatically create a swarm cluster of Docker, and the first node will be the manager and others will be worker.


# Usage

For user in China, you can type the following commnad for using the [Aliyun Mirrors](http://mirrors.aliyun.com) to speed up the package installation/update.

    export export USE_ALIYUN_MIRROR=1


This application is available in the form of a Docker image that you can run as a container by executing this command:
    
    vagrant up



# Play with it

Run the Swarm manager 

	vagrant ssh node-1


```
docker info
docker node ls
```

# References
[Swarm mode overview][1]

[1]: https://docs.docker.com/engine/swarm/
