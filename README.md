
Arquitectura Multi-región con Alta Disponibilidad en AWS

Contexto del Proyecto


Una empresa ACME requiere implementar una plataforma de procesamiento de transacciones financieras que debe operar con alta disponibilidad across múltiples regiones de AWS. El sistema debe manejar cargas variables y garantizar continuidad del servicio ante fallos regionales.

Objetivo Principal

Diseñar e implementar una arquitectura multi-región resiliente utilizando Amazon EKS con capacidades de failover automático y balanceo de carga global


Requerimientos Técnicos Específicos

1. Infraestructura Core Regiones requeridas: 2 Componentes de red:
2. 
● VPC con subnets públicas y privadas en cada región

● Conectividad inter-regional

● NATs internet desde subnets privadas

● Security Groups con reglas específicas para cada tier
Clusters EKS:

● Un cluster EKS por región

● Configuración de node groups


● Implementación de cluster autoscaler

● Configuración de RBAC apropiado

   2. Aplicación y Servicios
Microservicio de ejemplo: Desplegar una aplicación web simple (puede ser solo un nginx) que exponga.
3. Balanceo y Failover
4. 
● Según consideres necesario 4. Automatización

Pipeline de despliegue:
● Despliegue automático a ambas regiones ( Se ha utilizado CI/CD con Github Actions par el tema del despliegue )


1. Documentación Técnica durante la presentación Arquitectura:
2. 
● Diagrama de arquitectura detallado usando draw.io o similar


<img width="903" height="649" alt="Captura de pantalla 2025-09-16 a la(s) 19 19 15" src="https://github.com/user-attachments/assets/ccfad7cc-bd45-4961-9c84-f9649f38ad35" />

2. Código y Configuración Infraestructura como Código:
   
● Implementación usando Terraform (preferido) o CDK Configuración de Kubernetes: ( Se ha utilizado terraform para la implementacion de la IAC )

● Manifests YAML para la aplicación

4. Demostración Práctica Simulación de Failover:
   
● Script para simular falla en región primaria

● Evidencia de que el tráfico se redirige automáticamente



