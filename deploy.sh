docker build -t francescoagosti/multi-client:latest -t francescoagosti/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t francescoagosti/multi-server:latest -t francescoagosti/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t francescoagosti/multi-worker:latest -t francescoagosti/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push francescoagosti/multi-client:latest
docker push francescoagosti/multi-server:latest
docker push francescoagosti/multi-worker:latest
docker push francescoagosti/multi-client:$SHA
docker push francescoagosti/multi-server:$SHA
docker push francescoagosti/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=francescoagosti/multi-server:$SHA
kubectl set image deployments/client-deployment client=francescoagosti/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=francescoagosti/mutli-worker:$SHA
