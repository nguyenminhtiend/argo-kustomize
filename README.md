# Kustomize + Argo CD Local Practice

## Phase 1: Basic Kustomize Practice

### 1. Create Kind Cluster

```bash
kind create cluster --config kind-config.yaml --name kustomize-practice
```

### 2. Practice Structure

```
base/                 # Base configurations
├── deployment.yaml
├── service.yaml
├── configmap.yaml
└── kustomization.yaml

overlays/
├── dev/             # Development environment
│   ├── kustomization.yaml
│   ├── deployment-patch.yaml
│   └── configmap-patch.yaml
├── staging/         # Staging environment
│   ├── kustomization.yaml
│   ├── deployment-patch.yaml
│   └── configmap-patch.yaml
└── prod/           # Production environment
    ├── kustomization.yaml
    ├── deployment-patch.yaml
    └── configmap-patch.yaml
```

### 3. Commands to Practice

```bash
# Build and apply each environment
kustomize build base
kustomize build overlays/dev | kubectl apply -f -
kustomize build overlays/staging | kubectl apply -f -
kustomize build overlays/prod | kubectl apply -f -

# Diff between environments
kustomize build overlays/dev > dev.yaml
kustomize build overlays/prod > prod.yaml
diff dev.yaml prod.yaml
```

## Phase 2: Argo CD Setup

### 1. Install Argo CD

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### 2. Access Argo CD UI

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
# Get initial password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

### 3. Create Applications

- Git repository based applications
- Kustomize based applications
- Auto-sync vs manual sync
- Rollback scenarios

## Phase 3: GitOps Workflow

1. Create Git repo for configurations
2. Set up Argo CD applications
3. Practice deployment workflows
4. Test rollback scenarios
5. Multi-environment promotion
