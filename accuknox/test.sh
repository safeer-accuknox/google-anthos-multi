#!/bin/bash

# Namespaces
kubectl get namespace agents -o yaml
kubectl get namespace kubearmor -o yaml

# CustomResourceDefinition
kubectl get crd discoveredpolicies.security.kubearmor.com -o yaml

# Service Accounts
kubectl get sa agents-operator -n agents -o yaml
kubectl get sa discovery-engine -n agents -o yaml
kubectl get sa kmux -n agents -o yaml
kubectl get sa policy-enforcement-agent -n agents -o yaml
kubectl get sa shared-informer-agent -n agents -o yaml
kubectl get sa kubearmor-operator -n agents -o yaml

# Roles
kubectl get role kmux -n agents -o yaml
kubectl get role kubearmor-operator-tls-secrets-role -n agents -o yaml

# ClusterRoles
kubectl get clusterrole agents-operator -o yaml
kubectl get clusterrole kmux -o yaml
kubectl get clusterrole kubearmor-operator-clusterrole -o yaml
kubectl get clusterrole kubearmor-operator-manage-controller-clusterrole -o yaml
kubectl get clusterrole kubearmor-operator-manage-kubearmor-clusterrole -o yaml
kubectl get clusterrole manage-policies -o yaml
kubectl get clusterrole policy-enforcement-agent -o yaml
kubectl get clusterrole shared-informer-agent -o yaml
kubectl get clusterrole view-cluster-resources -o yaml

# RoleBindings
kubectl get rolebinding kmux -n agents -o yaml
kubectl get rolebinding kubearmor-operator-tls-secrets-rolebinding -n agents -o yaml

# ClusterRoleBindings
kubectl get clusterrolebinding agents-operator -o yaml
kubectl get clusterrolebinding kmux -o yaml
kubectl get clusterrolebinding kubearmor-operator-clusterrole-binding -o yaml
kubectl get clusterrolebinding kubearmor-operator-manage-controller-clusterrole-binding -o yaml
kubectl get clusterrolebinding kubearmor-operator-manage-kubearmor-clusterrole-binding -o yaml
kubectl get clusterrolebinding manage-policies -o yaml
kubectl get clusterrolebinding policy-enforcement-agent -o yaml
kubectl get clusterrolebinding shared-informer-agent -o yaml
kubectl get clusterrolebinding view-cluster-resources -o yaml

# ConfigMaps
kubectl get configmap agents-operator -n agents -o yaml
kubectl get configmap azuresentinel-vars -n agents -o yaml
kubectl get configmap cilium-vars -n agents -o yaml
kubectl get configmap discovery-engine-discover -n agents -o yaml
kubectl get configmap discovery-engine-hardening -n agents -o yaml
kubectl get configmap discovery-engine-offloader -n agents -o yaml
kubectl get configmap discovery-engine-sumengine -n agents -o yaml
kubectl get configmap discovery-engine-vars -n agents -o yaml
kubectl get configmap kmux -n agents -o yaml
kubectl get configmap kubearmor-vars -n agents -o yaml
kubectl get configmap onboarding-vars -n agents -o yaml
kubectl get configmap policy-enforcement-agent -n agents -o yaml
kubectl get configmap shared-informer-agent -n agents -o yaml
kubectl get configmap spire-vars -n agents -o yaml
kubectl get configmap splunk-vars -n agents -o yaml

# Secrets
kubectl get secret spire-agent-secret -n agents -o yaml

# Services
kubectl get service agents-operator -n agents -o yaml
kubectl get service discovery-engine -n agents -o yaml

# Deployments
kubectl get deployment agents-operator -n agents -o yaml
kubectl get deployment discovery-engine -n agents -o yaml
kubectl get deployment feeder-service -n agents -o yaml
kubectl get deployment policy-enforcement-agent -n agents -o yaml
kubectl get deployment shared-informer-agent -n agents -o yaml
kubectl get deployment ubuntu -n agents -o yaml
kubectl get deployment kubearmor-operator -n agents -o yaml

# Custom Resources (kubearmorconfig, kubearmorpolicy)
kubectl get kubearmorconfig kubearmorconfig-default -n agents -o yaml
kubectl get kubearmorpolicy block-pkg-mgmt-tools-exec -n agents -o yaml
