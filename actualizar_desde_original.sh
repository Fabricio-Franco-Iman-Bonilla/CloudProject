#!/bin/bash

# Variables configurables
ORIGINAL_REPO_URL="https://github.com/geraldinRC/Capibaras-V2.git"
ORIGINAL_REMOTE_NAME="original"
ORIGINAL_BRANCH="main"

echo "======================================"
echo "🛠️  ACTUALIZANDO DESDE REPO ORIGINAL"
echo "======================================"

# Verificar si el remote ya está agregado
if ! git remote | grep -q "$ORIGINAL_REMOTE_NAME"; then
    echo "🔗 Agregando el remote '$ORIGINAL_REMOTE_NAME'..."
    git remote add $ORIGINAL_REMOTE_NAME $ORIGINAL_REPO_URL
else
    echo "✅ Remote '$ORIGINAL_REMOTE_NAME' ya existe."
fi

# Guardar cambios locales
echo "📦 Guardando cambios locales (stash)..."
git stash push -m "Backup antes de merge automático"

# Obtener cambios del repositorio original
echo "⬇️  Obteniendo cambios del repositorio original..."
git fetch $ORIGINAL_REMOTE_NAME

# Realizar el merge con permiso para historias no relacionadas
echo "🔄 Haciendo merge con --allow-unrelated-histories..."
git merge $ORIGINAL_REMOTE_NAME/$ORIGINAL_BRANCH --allow-unrelated-histories

# Verificar si hubo conflictos
if [ $? -ne 0 ]; then
    echo "⚠️  Conflictos detectados durante el merge."
    echo "📝 Por favor resuélvelos manualmente y luego ejecuta:"
    echo "    git add ."
    echo "    git commit -m 'Conflictos resueltos'"
    echo "    git stash pop (si quieres recuperar tus cambios locales)"
else
    # Restaurar tu stash si todo fue bien
    if git stash list | grep -q "Backup antes de merge automático"; then
        echo "📤 Restaurando cambios locales guardados..."
        git stash pop
    else
        echo "📁 No hay cambios locales previos que restaurar."
    fi
    echo "✅ Merge completado sin conflictos."
fi