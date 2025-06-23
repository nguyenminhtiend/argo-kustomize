#!/bin/bash

set -e

echo "🚀 Setting up Kustomize + Argo CD practice environment..."

# Create Kind cluster
echo "Creating Kind cluster..."
kind create cluster --config kind-config.yaml --name kustomize-practice

# Wait for cluster to be ready
echo "Waiting for cluster to be ready..."
kubectl wait --for=condition=Ready nodes --all --timeout=300s

# Install Argo CD
echo "Installing Argo CD..."
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for Argo CD to be ready
echo "Waiting for Argo CD to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd

# Install Argo CD CLI
echo "Installing Argo CD CLI..."
if ! command -v argocd &> /dev/null; then
    brew install argocd
fi

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Get Argo CD admin password:"
echo "   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
echo ""
echo "2. Port forward to access Argo CD UI:"
echo "   kubectl port-forward svc/argocd-server -n argocd 8080:443"
echo ""
echo "3. Access Argo CD UI at: https://localhost:8080"
echo "   Username: admin"
echo "   Password: <from step 1>"