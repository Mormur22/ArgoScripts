#!/bin/bash

# Directorios
SCRIPTS_DIR="./scripts"
KUSTOMIZE_DIR="./config-maps"
KUSTOMIZE_FILE="$KUSTOMIZE_DIR/kustomization.yaml"

# Crea el archivo si no existe
touch $KUSTOMIZE_FILE

# Verifica si el encabezado ya existe
if ! grep -q "configMapGenerator:" $KUSTOMIZE_FILE; then
    echo "configMapGenerator:" > $KUSTOMIZE_FILE
fi

# Bucle a través de cada archivo .py y añadirlo al kustomization.yaml
for script in $SCRIPTS_DIR/*.py; do
    script_name=$(basename $script .py)
    # Verifica si el script ya se ha añadido al archivo kustomization.yaml
    if ! grep -q "$script_name-script" $KUSTOMIZE_FILE; then
        cat <<EOL >> $KUSTOMIZE_FILE
- name: $script_name-script
  namespace: spark-jobs
  files:
  - ../scripts/$script_name.py
EOL
    fi
done

