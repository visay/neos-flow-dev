This is repository for my personal Neos / Flow development setup using docker.

Usage:
=====

1. Clone the repository:

```bash
git clone https://github.com/visay/neos-flow-dev.git /path/to/your/local/workspace
```

2. Get into your local workspace and pull Neos and Flow source code:

```bash
cd /path/to/your/local/workspace
git clone https://github.com/neos/neos-development-distribution.git
git clone https://github.com/neos/flow-development-distribution.git
```

```bash
cd /path/to/your/local/workspace
git clone https://github.com/neos/neos-base-distribution.git
git clone https://github.com/neos/flow-base-distribution.git
```

If you also need the base distribution for comparison:

3. Install dependencies for Neos and Flow:

```bash
cd /path/to/your/local/workspace/neos-development-distribution
composer update

cd /path/to/your/local/workspace/flow-development-distribution
composer update
```

If base distribution needed:

```bash
cd /path/to/your/local/workspace/neos-base-distribution
composer update

cd /path/to/your/local/workspace/flow-base-distribution
composer update
```

4. Build local docker images for development and start docker containers:

```bash
cd /path/to/your/local/workspace
docker-compose build
docker-compose up -d
```

5. Update your hosts file to point Neos and Flow domains docker container. I'm using Ubuntu so for me, it is this line
in `/etc/hosts`

```ini
0.0.0.0 neos.dev flow.dev
```

For base distribution:

```ini
0.0.0.0 neos.base flow.base
```

6. You should be able to start Neos setup wizard or view Flow welcome page:

	- http://neos.dev/setup
	- http://flow.dev

For base distribution:

	- http://neos.base/setup
	- http://flow.base

Database information
====================

Neos Development Distribution
-----------------------------

- driver: `pdo_mysql`
- host: `db-neos-dev`
- user: `root`
- password: `root`
- database name: `neos-dev`

Flow Development Distribution
-----------------------------

- driver: `pdo_mysql`
- host: `db-flow-dev`
- user: `root`
- password: `root`
- database name: `flow-dev`

Neos Base Distribution
-----------------------------

- driver: `pdo_mysql`
- host: `db-neos-base`
- user: `root`
- password: `root`
- database name: `neos-base`

Flow Base Distribution
-----------------------------

- driver: `pdo_mysql`
- host: `db-flow-base`
- user: `root`
- password: `root`
- database name: `flow-base`

Contribution to Neos / Flow project:
====================================

Follow the rest of steps in https://discuss.neos.io/t/development-setup

Customization
=============

View `docker-compose.yml` file and adjust to your need 

- TODO: write description of each custom setting

Troubleshooting
===============

```bash
docker-compose ps
```

should return result like below (Ubuntu):

```bash
           Name                         Command               State               Ports
--------------------------------------------------------------------------------------------------
neosflowdev_app_1            /entrypoint.sh php-fpm7.0        Up       9000/tcp
neosflowdev_data_1           /bin/true                        Exit 0
neosflowdev_db-flow-base_1   docker-entrypoint.sh mysql ...   Up       3306/tcp
neosflowdev_db-flow-dev_1    docker-entrypoint.sh mysql ...   Up       3306/tcp
neosflowdev_db-neos-base_1   docker-entrypoint.sh mysql ...   Up       3306/tcp
neosflowdev_db-neos-dev_1    docker-entrypoint.sh mysql ...   Up       3306/tcp
neosflowdev_web_1            /entrypoint.sh nginx -g da ...   Up       443/tcp, 0.0.0.0:80->80/tcp
```

If a container (except the `data` container) is not running properly, try removing all containers as below and 
restart from step 4 above:

```bash
docker-compose kill
docker-compose rm -f
```

If a container (except the `data` container) is still not running, view the logs of the failed container and you should
get a hint of why:

```bash
docker-compose logs <db-flow-dev|db-neos-dev|db-flow-base|db-neos-base|web|app>
```
