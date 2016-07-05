#!/bin/bash

USE_ALIYUN_MIRROR=1

MANAGER_IP=$1
NODE_IP=$2

if ! which docker >/dev/null 2>&1; then
	if [ USE_ALIYUN_MIRROR ]
	then
		sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list
		curl -sSL http://aliyungo.oss-cn-hangzhou.aliyuncs.com/experimental-internet | sh
		echo DOCKER_OPTS="'--registry-mirror https://6udu7vtl.mirror.aliyuncs.com'" > /etc/default/docker
		sudo service docker restart
	else
		curl -sSL https://experimental.docker.com/ | sh
	fi
	gpasswd -a vagrant docker
	docker swarm join --listen-addr ${NODE_IP}:2377 ${MANAGER_IP}:2377
fi



