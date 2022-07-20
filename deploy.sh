docker build -t xqopxcat/multi-client:latest -t xqopxcat/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t xqopxcat/multi-server:latest -t xqopxcat/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t xqopxcat/multi-worker:latest -t xqopxcat/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push xqopxcat/multi-client:latest
docker push xqopxcat/multi-server:latest
docker push xqopxcat/multi-worker:latest

docker push xqopxcat/multi-client:$SHA
docker push xqopxcat/multi-server:$SHA
docker push xqopxcat/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=xqopxcat/multi-server:$SHA
kubectl set image deployments/client-deployment client=xqopxcat/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=xqopxcat/multi-worker:$SHA