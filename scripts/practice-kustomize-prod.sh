#!/bin/bash

set -e

echo "🔧 Kustomize Practice - PRODUCTION Environment"
echo "==============================================="

# Create production namespace
echo "Creating production namespace..."
kubectl create namespace production --dry-run=client -o yaml | kubectl apply -f -

echo ""
echo "1. Building base configuration:"
echo "kustomize build base"
kustomize build base

echo ""
echo "2. Building prod overlay:"
echo "kustomize build overlays/prod"
kustomize build overlays/prod

echo ""
echo "3. Applying production environment:"
kustomize build overlays/prod | kubectl apply -f -

echo ""
echo "4. Checking production deployment:"
kubectl get deployments -n production

echo ""
echo "5. Checking production configmap:"
kubectl get configmaps -n production

echo ""
echo "6. Checking production pods:"
kubectl get pods -n production

echo ""
echo "✅ Production environment deployed!"
echo ""
echo "To clean up production:"
echo "kubectl delete namespace production"