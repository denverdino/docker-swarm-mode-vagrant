#!/bin/bash

USE_ALIYUN_MIRROR=1

MANAGER_IP=$1

if ! which docker >/dev/null 2>&1; then
	if [ USE_ALIYUN_MIRROR ]
	then
		sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list
		curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
		echo DOCKER_OPTS="'--registry-mirror https://6udu7vtl.mirror.aliyuncs.com'" > /etc/default/docker
		sudo service docker restart
	else
		curl -sSL https://get.docker.com/ | sh
	fi
	gpasswd -a vagrant docker
	docker swarm init --listen-addr ${MANAGER_IP}:2377 --advertise-addr ${MANAGER_IP}
	docker swarm join-token -q worker >> /vagrant/worker_token
fi

