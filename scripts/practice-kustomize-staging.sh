#!/bin/bash

set -e

echo "🔧 Kustomize Practice - STAGING Environment"
echo "============================================"

# Create staging namespace
echo "Creating staging namespace..."
kubectl create namespace staging --dry-run=client -o yaml | kubectl apply -f -

echo ""
echo "1. Building base configuration:"
echo "kustomize build base"
kustomize build base

echo ""
echo "2. Building staging overlay:"
echo "kustomize build overlays/staging"
kustomize build overlays/staging

echo ""
echo "3. Applying staging environment:"
kustomize build overlays/staging | kubectl apply -f -

echo ""
echo "4. Checking staging deployment:"
kubectl get deployments -n staging

echo ""
echo "5. Checking staging configmap:"
kubectl get configmaps -n staging

echo ""
echo "6. Checking staging pods:"
kubectl get pods -n staging

echo ""
echo "✅ Staging environment deployed!"
echo ""
echo "To clean up staging:"
echo "kubectl delete namespace staging"