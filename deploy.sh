docker build -t billweng/multi-client:latest -t billweng/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t billweng/multi-server:latest -t billweng/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t billweng/multi-worker:latest -t billweng/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push billweng/multi-client:latest
docker push billweng/multi-server:latest
docker push billweng/multi-worker:latest
docker push billweng/multi-client:$GIT_SHA
docker push billweng/multi-server:$GIT_SHA
docker push billweng/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=billweng/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=billweng/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=billweng/multi-worker:$GIT_SHA
