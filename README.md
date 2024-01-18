# ChurchCRM Docker Setup

This repository contains the necessary configuration files to set up ChurchCRM using Docker.

## What is ChurchCRM?

[ChurchCRM](https://churchcrm.io/) is an open-source project that help churches management in some branches, as financial, events, sunday school, volunteer work and more.

## Getting Started

1. Clone this repository to your local machine.

2. Copy the `.env.example` file to a new file named `.env`.

3. Update the `.env` file with your specific settings. Be sure to change all the placeholder values, especially the `MYSQL_ROOT_PASSWORD`, `MYSQL_PASSWORD`, and `REDIS_PASSWORD`.

4. Run the following commands to build and start the Docker containers:

```sh
docker-compose build
docker-compose up
```

## Structure

`docker-compose.yml`: This file defines the Docker services, networks, and volumes. It includes the ChurchCRM application, a MariaDB database, and a Redis instance for session handling.

`60-churchcrm`: This is a script that sets up the ChurchCRM application. It downloads the latest release from the ChurchCRM GitHub repository, extracts it, and configures it with the settings from the .env file.

`.env.example`: This file contains example environment variables for the Docker services. Copy this file to `.env` and update the values before starting the Docker containers. **THIS FILE CONTAINS DEFAULT VALUES AND YOU MUST TO CHANGE IT BEFORE START USING THIS IMAGE.**

## Volumes

The Docker setup includes a volume named `churchcrm-files` for persistent storage of ChurchCRM files. This volume is mounted to several directories in the ChurchCRM container. Also, there's another volume called `churchcrm-db`, to store database.

## Ports

The ChurchCRM application is accessible at port 8080 on the host machine and can be changed for any port you want. The Redis service is accessible at port 6379.

## Security

Please ensure to use secure, random passwords in the `.env` file for production deployments.

## Note

This repo is based on work of original work from [@DawoudIO](https://github.com/DawoudIO), on original repo for [ChurchCRM Docker](https://github.com/ChurchCRM/Docker). All I done here it's only update and improve his original work.

If you can, pay him a coffee and try to help ChurchCRM project with something (like translations, documentation, etc).

## License

Following original repo of ChurchCRM, this repo has MIT License. You can [read the license here](LICENSE).

--

## Known issues

- using `docker-compose` makes UI of app shows lack of `integrityCheck.json` file. This error doesn't occur using only `Dockerfile`, so I need to investigate better.
