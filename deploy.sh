docker build -t senuch/multi-client:latest -t senuch/multi-client:$SHA -f ./complex/client ./complex/client
docker build -t senuch/multi-server:latest -t senuch/multi-server:$SHA -f ./complex/server ./complex/server
docker build -t senuch/multi-worker:latest -t senuch/multi-worker:$SHA -f ./complex/worker ./complex/worker
docker push senuch/multi-client:latest
docker push senuch/multi-server:latest
docker push senuch/multi-worker:latest

docker push senuch/multi-client:$SHA
docker push senuch/multi-server:$SHA
docker push senuch/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=senuch/multi-server:$SHA
kubectl set image deployments/client-deployment server=senuch/multi-client:$SHA
kubectl set image deployments/worker-deployment server=senuch/multi-worker:$SHA