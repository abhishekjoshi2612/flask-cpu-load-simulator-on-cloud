# Flask CPU Load Simulator on Cloud

This repository contains a simple Flask application that simulates CPU load, designed for cloud deployment using Kubernetes.

## Table of Contents

* [Features](#features)
* [Getting Started](#getting-started)
    * [Prerequisites](#prerequisites)
    * [Installation](#installation)
    * [Running Locally (Docker)](#running-locally-docker)
    * [Deployment to Kubernetes](#deployment-to-kubernetes)


## Features

* Simulates CPU load.
* Deployed on Kubernetes for scalability and resilience.
* Uses a multi-stage Docker build for optimized image size.
* Implements Horizontal Pod Autoscaler (HPA) based on CPU utilization.
* Targets 60% pod utilization.

## Getting Started


### Prerequisites

* Python 3.x
* Flask
* Docker
* Kubernetes cluster (e.g., EKS, Minikube, Kind)
* `kubectl`
* `eksctl` (if using EKS)
* Metrics Server (for HPA) (https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml)

### Installation
1. Clone the repository:
![Screenshot 2025-01-30 184309](https://github.com/user-attachments/assets/3e1e327d-723a-41a0-b365-27ff2fde6cfc)

```bash
git clone <your_repo_url>
cd flask-cpu-load-simulator-on-cloud

2. Install the1 dependencies: pip install -r requirements.txt

### Running Locally (Docker)
![docker-file-ss](https://github.com/user-attachments/assets/7e17a23a-927a-4a77-996b-44e2776259e2)

3. Build the Docker image (multi-stage build):
3.1 docker build -t <your_dockerhub_username>/abhishek-flask-app:latest .
3.2 Run the Docker container: docker run -d -p 80:80 --name abhishek-flask-app <your_dockerhub_username>/abhishek-flask-app:latest
3.3 Access the application at http://localhost:80.

### Deployment to Kubernetes
![pod-memory-usage](https://github.com/user-attachments/assets/206be1ba-8421-4f1d-98e4-760da60be30e)

4. Create EKS Cluster : eksctl create cluster --name abhishek-demo-cluster --region us-east-1

5. Install Metrics Server:
 kubectl apply -f [https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml](https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml)

6. Apply the configurations:
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f hpa.yaml

7. Access the Application: Get the external IP of the service using kubectl get service flask-cpu-load-simulator
![image](https://github.com/user-attachments/assets/a85e67ff-6052-4dea-917a-d40d1517d84a)




