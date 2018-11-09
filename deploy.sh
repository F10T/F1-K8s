docker build -t fatalis/multi-client:latest -t fatalis/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fatalis/multi-server:latest -t fatalis/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fatalis/multi-worker:latest -t fatalis/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push fatalis/multi-client:latest
docker push fatalis/multi-server:latest
docker push fatalis/multi-worker:latest

docker push fatalis/multi-client:$SHA
docker push fatalis/multi-server:$SHA
docker push fatalis/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=fatalis/multi-server:$SHA
kubectl set image deployments/client-deployment client=fatalis/multi-client:$SHA
kubectl set image deployments/worker-deplyoment worker=fatalis/multi-worker:$SHA
