#!/bin/bash

# Directorios
SCRIPTS_DIR="./scripts"
KUSTOMIZE_DIR="./configmaps"

# Encabezado del kustomization.yaml
echo "configMapGenerator:" > "$KUSTOMIZE_DIR/kustomization.yaml"

# Bucle a través de cada archivo .py y añadirlo al kustomization.yaml
for script in $SCRIPTS_DIR/*.py; do
    script_name=$(basename $script .py)
    cat <<EOL >> "$KUSTOMIZE_DIR/kustomization.yaml"
- name: $script_name-script
  namespace: spark-jobs
  files:
  - ../scripts/$script_name.py
EOL
done
