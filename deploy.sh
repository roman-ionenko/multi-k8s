docker build -t bgahavan/multi-client:latest -t bgahavan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bgahavan/multi-server:latest -t bgahavan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bgahavan/multi-worker:latest -t bgahavan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bgahavan/multi-client:latest
docker push bgahavan/multi-server:latest
docker push bgahavan/multi-worker:latest

docker push bgahavan/multi-client:$SHA
docker push bgahavan/multi-server:$SHA
docker push bgahavan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bgahavan/multi-server:$SHA
kubectl set image deployments/client-deployment client=bgahavan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bgahavan/multi-worker:$SHA