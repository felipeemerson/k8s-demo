docker build -t felipeemerson/multi-client:latest -t felipeemerson/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t felipeemerson/multi-server:latest -t felipeemerson/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t felipeemerson/multi-worker:latest -t felipeemerson/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push felipeemerson/multi-client:latest
docker push felipeemerson/multi-server:latest
docker push felipeemerson/multi-worker:latest

docker push felipeemerson/multi-client:$SHA
docker push felipeemerson/multi-server:$SHA
docker push felipeemerson/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=felipeemerson/multi-client:$SHA
kubectl set image deployments/server-deployment server=felipeemerson/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=felipeemerson/multi-worker:$SHA