#!/bin/bash

set -e

echo "🔧 Kustomize Practice Session"
echo "=============================="

# Create namespaces
echo "Creating namespaces..."
kubectl create namespace dev --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace staging --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace production --dry-run=client -o yaml | kubectl apply -f -

echo ""
echo "1. Building base configuration:"
echo "kustomize build base"
kustomize build base

echo ""
echo "2. Building dev overlay:"
echo "kustomize build overlays/dev"
kustomize build overlays/dev

echo ""
echo "3. Building staging overlay:"
echo "kustomize build overlays/staging"
kustomize build overlays/staging

echo ""
echo "4. Building prod overlay:"
echo "kustomize build overlays/prod"
kustomize build overlays/prod

echo ""
echo "5. Applying dev environment:"
kustomize build overlays/dev | kubectl apply -f -

echo ""
echo "6. Applying staging environment:"
kustomize build overlays/staging | kubectl apply -f -

echo ""
echo "7. Applying prod environment:"
kustomize build overlays/prod | kubectl apply -f -

echo ""
echo "8. Checking deployments:"
kubectl get deployments -A | grep nginx

echo ""
echo "9. Checking configmaps:"
kubectl get configmaps -A | grep app-config

echo ""
echo "✅ Kustomize practice complete!"
echo ""
echo "To clean up:"
echo "kubectl delete namespace dev staging production"