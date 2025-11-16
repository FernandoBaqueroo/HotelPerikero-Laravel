@echo off
echo ========================================
echo    Configuracion de Hotel Perikero
echo    con Docker Sail
echo ========================================
echo.

echo [1/6] Copiando archivo de configuracion...
copy .env.example .env
if errorlevel 1 (
    echo Error: No se pudo copiar .env.example a .env
    pause
    exit /b 1
)

echo [2/6] Instalando dependencias de Composer...
composer install
if errorlevel 1 (
    echo Error: No se pudo instalar las dependencias de Composer
    pause
    exit /b 1
)

echo [3/6] Instalando dependencias de NPM...
npm install
if errorlevel 1 (
    echo Error: No se pudo instalar las dependencias de NPM
    pause
    exit /b 1
)

echo [4/6] Iniciando contenedores de Docker...
./vendor/bin/sail up -d
if errorlevel 1 (
    echo Error: No se pudo iniciar los contenedores de Docker
    pause
    exit /b 1
)

echo [5/6] Generando clave de aplicacion...
./vendor/bin/sail artisan key:generate
if errorlevel 1 (
    echo Error: No se pudo generar la clave de aplicacion
    pause
    exit /b 1
)

echo [6/6] Ejecutando migraciones y seeders...
./vendor/bin/sail artisan migrate --seed
if errorlevel 1 (
    echo Error: No se pudo ejecutar las migraciones
    pause
    exit /b 1
)

echo.
echo ========================================
echo    ¡Configuracion completada!
echo ========================================
echo.
echo La aplicacion esta disponible en:
echo - Web: http://localhost
echo - Mailpit: http://localhost:8025
echo.
echo Para compilar assets del frontend:
echo ./vendor/bin/sail npm run dev
echo.
echo Para detener los contenedores:
echo ./vendor/bin/sail down
echo.
pause
