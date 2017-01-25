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

3. Install dependencies for Neos and Flow:

```bash
cd /path/to/your/local/workspace/neos-development-distribution
composer update

cd /path/to/your/local/workspace/flow-development-distribution
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

6. You should be able to start Neos setup wizard or view Flow welcome page:

	- http://neos.dev/setup
	- http://flow.dev

Database information
====================

Neos
----

- driver: `pdo_mysql`
- host: `neos-db`
- user: `root`
- password: `root`
- database name: `neos`

Neos
----

- driver: `pdo_mysql`
- host: `flow-db`
- user: `root`
- password: `root`
- database name: `flow`

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
        Name                       Command               State               Ports            
---------------------------------------------------------------------------------------------
neosflowdev_app_1       /entrypoint.sh php-fpm7.0        Up       9000/tcp                    
neosflowdev_data_1      /bin/true                        Exit 0                               
neosflowdev_flow-db_1   docker-entrypoint.sh mysql ...   Up       3306/tcp                    
neosflowdev_neos-db_1   docker-entrypoint.sh mysql ...   Up       3306/tcp                    
neosflowdev_web_1       /entrypoint.sh nginx -g da ...   Up       443/tcp, 0.0.0.0:80->80/tcp
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
docker-compose logs <flow-db|neos-db|web|app>
```
