docker build -t domcull3n/multi-client:latest -t domcull3n/multi-client:$SHA ./client
docker build -t domcull3n/multi-server:latest -t domcull3n/multi-server:$SHA ./server
docker build -t domcull3n/multi-worker:latest -t domcull3n/multi-worker:$SHA ./worker

docker push domcull3n/multi-client:latest
docker push domcull3n/multi-server:latest
docker push domcull3n/multi-worker:latest

docker push domcull3n/multi-client:$SHA
docker push domcull3n/multi-server:$SHA
docker push domcull3n/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=domcull3n/multi-server:$SHA
kubectl set image deployments/client-deployment client=domcull3n/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=domcull3n/multi-worker:$SHA