#! /bin/bash
manager=$(hostname -I | awk '{print $1}')
Token=$(docker swarm join-token manager -q)

docker swarm join --token SWMTKN-1-$Token $manager:2377
