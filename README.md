
# Documentación del Proyecto de Reserva de Hotel con Parking

## Índice

- [Introducción](#introducción)
- [Requisitos del sistema](#requisitos-del-sistema)
- [Configuración inicial](#configuración-inicial)
- [Funcionalidades](#funcionalidades)
  - [Reservas de Habitación](#reservas-de-habitación)
  - [Gestión de Parking](#gestión-de-parking)
  - [Panel de Recepcionista](#panel-de-recepcionista) 
  - [Panel de Gestor de Parking](#panel-de-gestor-de-parking)

## Introducción

Este documento proporciona una visión general de un sistema de reserva de habitaciones de hotel con la funcionalidad adicional de reservar plazas de parking. El sistema permite a los usuarios seleccionar una habitación y, opcionalmente, una plaza de parking durante su estancia.

## Requisitos del sistema

- Docker Desktop
- Composer (para instalación inicial)
- Node.js (para instalación inicial)

## Configuración inicial con Docker Sail

### Opción 1: Configuración automática (Recomendada)

1. Clona el repositorio del proyecto.
2. Navega al directorio del proyecto Laravel:
   ```bash
   cd HotelPerikero-Laravel
   ```
3. Ejecuta el script de configuración automática:

   **En Windows:**
   ```cmd
   setup-sail.bat
   ```

   **En Linux/macOS:**
   ```bash
   ./setup-sail.sh
   ```

### Opción 2: Configuración manual

1. Clona el repositorio del proyecto.
2. Navega al directorio del proyecto Laravel:
   ```bash
   cd HotelPerikero-Laravel
   ```
3. Copia el archivo de configuración:
   ```bash
   cp .env.example .env
   ```
4. Instala las dependencias de Composer:
   ```bash
   composer install
   ```
5. Instala las dependencias de NPM:
   ```bash
   npm install
   ```
6. Inicia los contenedores de Docker:
   ```bash
   ./vendor/bin/sail up -d
   ```
7. Genera la clave de aplicación:
   ```bash
   ./vendor/bin/sail artisan key:generate
   ```
8. Ejecuta las migraciones y seeders:
   ```bash
   ./vendor/bin/sail artisan migrate --seed
   ```
9. Compila los assets del frontend:
   ```bash
   ./vendor/bin/sail npm run dev
   ```

## Acceso a la aplicación

- **Aplicación web:** http://localhost
- **Mailpit (interfaz de correo):** http://localhost:8025
- **Base de datos:** localhost:3306 (usuario: sail, contraseña: password)

## Comandos útiles de Docker Sail

```bash
# Iniciar contenedores
./vendor/bin/sail up -d

# Detener contenedores
./vendor/bin/sail down

# Ver logs
./vendor/bin/sail logs

# Ejecutar comandos de Artisan
./vendor/bin/sail artisan [comando]

# Ejecutar comandos de NPM
./vendor/bin/sail npm [comando]

# Acceder al contenedor
./vendor/bin/sail shell

# Reconstruir contenedores
./vendor/bin/sail build --no-cache
```

## Información de Inicio de Sesión
1. **ADMIN:** admin@admin.com / admin
2. **USER**  john.doe@example.com / password1

## Funcionalidades

### Reservas de Habitación

- **Crear Reserva**: Los usuarios pueden reservar una habitación seleccionando las fechas de check-in y check-out.
- - **Verificar Disponibilidad**: El sistema verifica la disponibilidad de las habitaciones para las fechas seleccionadas.
- **Ver Reserva**: Los usuarios pueden ver los detalles de sus reservas.
- **Modificar Reserva**: Los usuarios pueden modificar sus reservas existentes.
- **Cancelar Reserva**: Los usuarios pueden cancelar sus reservas.

### Gestión de Parking

- **Reservar Parking**: Durante la reserva de una habitación, los usuarios pueden optar por reservar una plaza de parking.
- **Verificar Disponibilidad**: El sistema verifica la disponibilidad de las plazas de parking para las fechas seleccionadas.
- **Asignación de Parking**: Una plaza de parking disponible se asigna automáticamente a la reserva.
- **Liberar Parking**: Cuando una reserva se cancela, la plaza de parking correspondiente se libera.

### Panel de Recepcionista

- **Crear Reservas Telefónicas**: El recepcionista puede introducir reservas en el sistema que se han recibido por teléfono.
- **Confirmar Reserva**: El recepcionista puede confirmar las reservas realizadas, asegurando la asignación de habitaciones y parking si es necesario.
- **Cancelar Reserva**: El recepcionista tiene la capacidad de cancelar reservas según sea necesario.
- **Ver Reservas Diarias**: Hay una funcionalidad para que el recepcionista vea todas las reservas para el día actual, facilitando la gestión diaria del hotel.

### Panel de Gestor de Parking

- **Visualización de Espacios**: El gestor de parking puede ver el estado actual de las plazas de parking.
- **Asignación de Plazas de Parking**: Puede asignar plazas de parking a las reservas que lo requieran.
- **Liberación de Plazas de Parking**: Cuando una reserva se cancela o termina, el gestor de parking puede marcar la plaza como disponible nuevamente.

## Despliegue en Railway

### Opción 1: Despliegue desde GitHub (Recomendado)

1. **Sube tu código a GitHub:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/tu-usuario/hotel-perikero.git
   git push -u origin main
   ```

2. **Conecta con Railway:**
   - Ve a [Railway.app](https://railway.app)
   - Inicia sesión con GitHub
   - Haz clic en "New Project"
   - Selecciona "Deploy from GitHub repo"
   - Elige tu repositorio

3. **Configura las variables de entorno:**
   - Ve a la pestaña "Variables"
   - Agrega las siguientes variables:
     ```
     APP_KEY=base64:tu-clave-generada
     APP_ENV=production
     APP_DEBUG=false
     APP_URL=https://tu-proyecto.railway.app
     ```

4. **Agrega base de datos MySQL:**
   - En el dashboard de Railway
   - Haz clic en "New" → "Database" → "MySQL"
   - Railway generará automáticamente las variables:
     - `MYSQL_HOST`
     - `MYSQL_PORT`
     - `MYSQL_DATABASE`
     - `MYSQL_USER`
     - `MYSQL_PASSWORD`

5. **Ejecuta migraciones:**
   - Ve a la pestaña "Deployments"
   - Haz clic en el botón "..." del deployment
   - Selecciona "Open Console"
   - Ejecuta: `php artisan migrate --seed`

### Opción 2: Despliegue desde CLI

1. **Instala Railway CLI:**
   ```bash
   npm install -g @railway/cli
   ```

2. **Inicia sesión:**
   ```bash
   railway login
   ```

3. **Inicializa el proyecto:**
   ```bash
   railway init
   ```

4. **Despliega:**
   ```bash
   railway up
   ```

5. **Configura variables:**
   ```bash
   railway variables set APP_KEY=base64:tu-clave-generada
   railway variables set APP_ENV=production
   railway variables set APP_DEBUG=false
   ```

6. **Agrega base de datos:**
   ```bash
   railway add mysql
   ```

7. **Ejecuta migraciones:**
   ```bash
   railway run php artisan migrate --seed
   ```

### Variables de entorno necesarias:

```env
APP_NAME=HotelPerikero
APP_ENV=production
APP_KEY=base64:tu-clave-generada
APP_DEBUG=false
APP_URL=https://tu-proyecto.railway.app

DB_CONNECTION=mysql
DB_HOST=${MYSQL_HOST}
DB_PORT=${MYSQL_PORT}
DB_DATABASE=${MYSQL_DATABASE}
DB_USERNAME=${MYSQL_USER}
DB_PASSWORD=${MYSQL_PASSWORD}

# Redis (opcional)
REDIS_HOST=${REDIS_HOST}
REDIS_PASSWORD=${REDIS_PASSWORD}
REDIS_PORT=${REDIS_PORT}
```

### Generar clave de aplicación:

```bash
php artisan key:generate --show
```

## Video Demostración

[![Demostración]](https://drive.google.com/file/d/1RwiQEp_Cu14HrR0IgDVlKmnMjDvbfDLF/view?usp=sharing)
