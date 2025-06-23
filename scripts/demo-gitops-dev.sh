#!/bin/bash

set -e

echo "🔄 GitOps Demo - DEV Environment Setup"
echo "====================================="

# Check if Argo CD is running
if ! kubectl get ns argocd &> /dev/null; then
    echo "❌ Argo CD not found. Run setup-cluster.sh first."
    exit 1
fi

echo "Creating dev application..."

# Apply dev application (auto-sync enabled)
kubectl apply -f argocd/applications/nginx-dev.yaml

echo ""
echo "✅ Dev environment created!"
echo ""
echo "Dev application status:"
kubectl get application nginx-dev -n argocd
echo ""
echo "Access Argo CD UI:"
echo "1. Port forward: kubectl port-forward svc/argocd-server -n argocd 8080:443"
echo "2. Get password: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
echo "3. Login at: https://localhost:8080 (username: admin)"
echo ""
echo "Dev environment features:"
echo "- Auto-sync enabled (watches git repo for changes)"
echo "- Deploys to 'dev' namespace"
echo "- Try modifying overlays/dev/deployment-patch.yaml and push to git!"