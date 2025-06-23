#!/bin/bash

set -e

echo "🔄 GitOps Demo - PRODUCTION Environment Setup"
echo "============================================="

# Check if Argo CD is running
if ! kubectl get ns argocd &> /dev/null; then
    echo "❌ Argo CD not found. Run setup-cluster.sh first."
    exit 1
fi

echo "Creating production application..."

# Apply prod application (manual sync)
kubectl apply -f argocd/applications/nginx-prod.yaml

echo ""
echo "✅ Production environment created!"
echo ""
echo "Production application status:"
kubectl get application nginx-prod -n argocd
echo ""
echo "Access Argo CD UI:"
echo "1. Port forward: kubectl port-forward svc/argocd-server -n argocd 8080:443"
echo "2. Get password: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
echo "3. Login at: https://localhost:8080 (username: admin)"
echo ""
echo "Production environment features:"
echo "- Manual sync only (requires approval in ArgoCD UI)"
echo "- Deploys to 'production' namespace"
echo "- Click 'SYNC' in ArgoCD UI to deploy changes"
echo "- ⚠️  Use with caution - this is production!"