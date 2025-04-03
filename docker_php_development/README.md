
# Docker PHP 8.2 & Nginx Development Setup

This repository provides a basic setup for running a PHP 8.2 environment with Nginx using Docker. It allows you to run multiple PHP-based applications in a development environment, with the ability to easily configure and scale. The setup includes a PHP 8.2 container, Nginx as the web server, and shared volumes for seamless development.

## Prerequisites

Ensure that you have the following installed:

- Docker: [Install Docker](https://docs.docker.com/get-docker/)
- Docker Compose: [Install Docker Compose](https://docs.docker.com/compose/install/)

## Getting Started

### 1. Clone the Repository

Clone this repository to your local machine:

```bash
git clone <repository-url>
cd <repository-name>
```

### 2. Directory Structure

Here is the basic directory structure of this setup:

```
.
├── apps
│   ├── php8.2
│   │   └── (your Laravel/PHP apps here)
├── docker-compose.dev.yml
├── nginx
│   └── enable
│       └── (nginx config files, e.g., tailwind-ts-dashboard-v1.test.conf)
└── php8.2
    ├── entrypoint.sh
    ├── php8.2.dockerfile
    └── (other PHP-related files)
```

### 3. Docker Compose Configuration

The `docker-compose.dev.yml` file defines two services:

- **nginx**: The web server that listens on port 80 and serves your application.
- **php8.2**: The PHP 8.2 container running your PHP application with the necessary extensions.

### 4. Running the Containers

To start the development environment, run the following command:

```bash
docker-compose -f docker-compose.dev.yml up -d --build
```

This will build the containers (if needed) and start them in the background.

### 5. Volumes and Configuration

- The `nginx` service will use the configuration from the `nginx/enable` folder and mount your PHP application from the `apps/php8.2` directory.
- The `php8.2` service will use the `php8.2.dockerfile` for building the container and also mount your PHP application from the `apps/php8.2` directory. It also has a custom `entrypoint.sh` to handle permission fixes at startup.

### 6. Customizing the Setup

- You can add more PHP projects inside the `apps/php8.2` folder. Each project can be configured using Nginx's virtual hosts.
- The Nginx configuration can be customized by editing files inside the `nginx/enable` folder.

### 7. Stopping the Containers

To stop the containers, use:

```bash
docker-compose -f docker-compose.dev.yml down
```

This will stop and remove the containers but retain the data volumes.

### 8. Updating the Containers

If you make changes to the Dockerfiles or the Nginx configuration, rebuild and restart the containers with:

```bash
docker-compose -f docker-compose.dev.yml up -d --build
```

## File Descriptions

- **docker-compose.dev.yml**: The Docker Compose configuration file that defines the services (Nginx and PHP 8.2).
- **php8.2/entrypoint.sh**: A script that runs at container startup to handle permission fixes for directories like `storage` and `bootstrap/cache` in Laravel applications.
- **nginx/enable**: Contains Nginx configuration files that define how Nginx serves your PHP applications.
- **php8.2/php8.2.dockerfile**: The Dockerfile used to build the PHP 8.2 container, installing necessary extensions and dependencies.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
