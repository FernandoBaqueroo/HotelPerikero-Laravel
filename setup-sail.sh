#!/bin/bash

echo "========================================"
echo "   Configuración de Hotel Perikero"
echo "   con Docker Sail"
echo "========================================"
echo

echo "[1/6] Copiando archivo de configuración..."
cp .env.example .env
if [ $? -ne 0 ]; then
    echo "Error: No se pudo copiar .env.example a .env"
    exit 1
fi

echo "[2/6] Instalando dependencias de Composer..."
composer install
if [ $? -ne 0 ]; then
    echo "Error: No se pudo instalar las dependencias de Composer"
    exit 1
fi

echo "[3/6] Instalando dependencias de NPM..."
npm install
if [ $? -ne 0 ]; then
    echo "Error: No se pudo instalar las dependencias de NPM"
    exit 1
fi

echo "[4/6] Iniciando contenedores de Docker..."
./vendor/bin/sail up -d
if [ $? -ne 0 ]; then
    echo "Error: No se pudo iniciar los contenedores de Docker"
    exit 1
fi

echo "[5/6] Generando clave de aplicación..."
./vendor/bin/sail artisan key:generate
if [ $? -ne 0 ]; then
    echo "Error: No se pudo generar la clave de aplicación"
    exit 1
fi

echo "[6/6] Ejecutando migraciones y seeders..."
./vendor/bin/sail artisan migrate --seed
if [ $? -ne 0 ]; then
    echo "Error: No se pudo ejecutar las migraciones"
    exit 1
fi

echo
echo "========================================"
echo "   ¡Configuración completada!"
echo "========================================"
echo
echo "La aplicación está disponible en:"
echo "- Web: http://localhost"
echo "- Mailpit: http://localhost:8025"
echo
echo "Para compilar assets del frontend:"
echo "./vendor/bin/sail npm run dev"
echo
echo "Para detener los contenedores:"
echo "./vendor/bin/sail down"
echo
