#!/usr/bin/env bash

echo "Building example image";
docker build -t localhost:5000/local/demo:latest .;
echo "Pushing the image to local Registry. So it's available for local Kubernetes Cluster";
docker push localhost:5000/local/demo;

echo "Deploying to Kubernetes cluster using Helm Chart";
helm install demo-chart buildachart/ --values buildachart/values.yaml;