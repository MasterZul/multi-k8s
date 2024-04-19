docker build -t masterzul/multi-client-k8s:latest -t masterzul/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t masterzul/multi-server-k8s:latest -t masterzul/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t masterzul/multi-worker-k8s:latest -t masterzul/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push masterzul/multi-client-k8s:latest
docker push masterzul/multi-server-k8s:latest
docker push masterzul/multi-worker-k8s:latest

docker push masterzul/multi-client-k8s:$SHA
docker push masterzul/multi-server-k8s:$SHA
docker push masterzul/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=masterzul/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=masterzul/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=masterzul/multi-worker-k8s:$SHA