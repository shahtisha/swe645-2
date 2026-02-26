# SWE 645 - Homework Assignment 2
# Student Survey App - Containerized with Docker, Deployed on Kubernetes via CI/CD

## What's in this repo

- `index.html` - Homepage
- `survey.html` - Student survey form
- `error.html` - Error page
- `img.jpg` - Background image
- `Dockerfile` - Containerizes the app using Nginx
- `deployment.yaml` - Kubernetes Deployment (3 replicas)
- `service.yaml` - Kubernetes LoadBalancer Service
- `Jenkinsfile` - CI/CD pipeline definition

## Quick Start

### Run locally with Docker
docker build -t studentsurvey645 .
docker run -p 8080:80 studentsurvey645
Then open: http://localhost:8080

### Deploy to Kubernetes
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl get pods
