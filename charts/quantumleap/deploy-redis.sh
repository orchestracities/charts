#!/bin/sh
helm install --name redis --set usePassword=false --namespace prod stable/redis

# Need to debug?
# kubectl run --namespace dev redis-redis-client --rm --tty -i --image bitnami/redis:4.0.6-r1 -- bash
# redis-cli -h redis-redis
