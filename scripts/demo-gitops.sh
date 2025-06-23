#!/bin/bash

set -e

echo "🔄 GitOps Demo with Argo CD"
echo "============================"

# Check if Argo CD is running
if ! kubectl get ns argocd &> /dev/null; then
    echo "❌ Argo CD not found. Run setup-cluster.sh first."
    exit 1
fi

echo "Creating demo applications..."

# Apply dev application (auto-sync enabled)
kubectl apply -f argocd/applications/nginx-dev.yaml

# Apply staging application (manual sync)
kubectl apply -f argocd/applications/nginx-staging.yaml

# Apply prod application (manual sync)
kubectl apply -f argocd/applications/nginx-prod.yaml

echo ""
echo "✅ Argo CD applications created!"
echo ""
echo "Access Argo CD UI:"
echo "1. Port forward: kubectl port-forward svc/argocd-server -n argocd 8080:443"
echo "2. Get password: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
echo "3. Login at: https://localhost:8080 (username: admin)"
echo ""
echo "Try these GitOps scenarios:"
echo "- Modify overlays/dev/deployment-patch.yaml and push to git"
echo "- Watch dev environment auto-sync"
echo "- Manually sync staging environment"
echo "- Practice rollback scenarios"