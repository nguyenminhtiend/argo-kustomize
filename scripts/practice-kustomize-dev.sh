#!/bin/bash

set -e

echo "🔧 Kustomize Practice - DEV Environment"
echo "========================================"

# Create dev namespace
echo "Creating dev namespace..."
kubectl create namespace dev --dry-run=client -o yaml | kubectl apply -f -

echo ""
echo "1. Building base configuration:"
echo "kustomize build base"
kustomize build base

echo ""
echo "2. Building dev overlay:"
echo "kustomize build overlays/dev"
kustomize build overlays/dev

echo ""
echo "3. Applying dev environment:"
kustomize build overlays/dev | kubectl apply -f -

echo ""
echo "4. Checking dev deployment:"
kubectl get deployments -n dev

echo ""
echo "5. Checking dev configmap:"
kubectl get configmaps -n dev

echo ""
echo "6. Checking dev pods:"
kubectl get pods -n dev

echo ""
echo "✅ Dev environment deployed!"
echo ""
echo "To clean up dev:"
echo "kubectl delete namespace dev"