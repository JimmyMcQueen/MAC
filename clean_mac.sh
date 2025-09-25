#!/bin/bash

echo "🚀 Limpieza avanzada de macOS iniciada"
echo "--------------------------------------"

# Ver espacio antes
echo "📊 Espacio libre ANTES:"
df -h /

# Preguntar antes de borrar
read -p "¿Quieres limpiar la papelera? (s/n): " resp
if [[ $resp == "s" ]]; then
  rm -rf ~/.Trash/*
  echo "🗑️ Papelera vaciada."
fi

read -p "¿Quieres limpiar la carpeta Descargas? (s/n): " resp
if [[ $resp == "s" ]]; then
  rm -rf ~/Downloads/*
  echo "📂 Descargas limpiadas."
fi

read -p "¿Quieres limpiar cachés de usuario? (s/n): " resp
if [[ $resp == "s" ]]; then
  rm -rf ~/Library/Caches/*
  echo "🧹 Cachés de usuario eliminados."
fi

read -p "¿Quieres limpiar logs del sistema? (s/n): " resp
if [[ $resp == "s" ]]; then
  sudo rm -rf /var/log/*
  echo "📜 Logs del sistema eliminados."
fi

# Limpiar RAM
echo "💾 Liberando RAM..."
sudo purge

# Reindexar Spotlight
echo "🔎 Reindexando Spotlight..."
sudo mdutil -E / > /dev/null

# Buscar archivos grandes
echo "🔍 Escaneo de archivos mayores a 1GB..."
sudo find / -type f -size +1G 2>/dev/null | tee ~/Desktop/archivos_grandes.txt
echo "📑 Lista guardada en Escritorio como 'archivos_grandes.txt'"

# Revisar snapshots locales
echo "🕒 Revisando snapshots locales de Time Machine..."
tmutil listlocalsnapshots /

# Verificar disco
echo "🔧 Verificando disco..."
diskutil verifyVolume /

# Reporte final
echo "--------------------------------------"
echo "📊 Espacio libre DESPUÉS:"
df -h /
echo "✅ Limpieza completa."
