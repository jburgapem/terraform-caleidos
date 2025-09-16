#!/bin/bash
# Simula la caída del servicio nginx en la región primaria y verifica el acceso en la secundaria
PRIMARY_CONTEXT="acme-eks-primary"
SECONDARY_CONTEXT="acme-eks-secondary"

if [ "$1" != "" ]; then
  PRIMARY_CONTEXT="$1"
fi
if [ "$2" != "" ]; then
  SECONDARY_CONTEXT="$2"
fi

echo "Eliminando el servicio nginx en la región primaria..."
kubectl config use-context "$PRIMARY_CONTEXT"
kubectl delete service nginx-service

echo "Verificando el servicio en la región secundaria..."
kubectl config use-context "$SECONDARY_CONTEXT"
kubectl get service nginx-service

echo "Failover simulado. El tráfico debe redirigirse a la región secundaria si el balanceo global está configurado."
