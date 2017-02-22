#!/usr/bin/env bash

WORKSPACE=`pwd`
RED='\033[0;31m'
NC='\033[0m'

echo
echo -e "${RED}#####################################"
echo -e "### Neos Development Distribution ###"
echo -e "#####################################${NC}"
echo
if [ -d "${WORKSPACE}/neos-development-distribution/.git" ]; then
  cd ${WORKSPACE}/neos-development-distribution
  git reset --hard origin/master
  git checkout master
  git pull origin master
else
  git clone https://github.com/neos/neos-development-distribution.git
fi
composer update -d ${WORKSPACE}/neos-development-distribution

echo
echo -e "${RED}#####################################"
echo -e "### Flow Development Distribution ###"
echo -e "#####################################${NC}"
echo
cd ${WORKSPACE}
if [ -d "${WORKSPACE}/flow-development-distribution/.git" ]; then
  cd ${WORKSPACE}/flow-development-distribution
  git reset --hard origin/master
  git checkout master
  git pull origin master
else
  git clone https://github.com/neos/flow-development-distribution.git
fi
composer update -d ${WORKSPACE}/flow-development-distribution

echo
echo -e "${RED}##############################"
echo -e "### Neos Base Distribution ###"
echo -e "##############################${NC}"
echo
cd ${WORKSPACE}
if [ -d "${WORKSPACE}/neos-base-distribution/.git" ]; then
  cd ${WORKSPACE}/neos-base-distribution
  git reset --hard origin/master
  git checkout master
  git pull origin master
else
  git clone https://github.com/neos/neos-base-distribution.git
fi
composer update -d ${WORKSPACE}/neos-base-distribution

echo
echo -e "${RED}##############################"
echo -e "### Flow Base Distribution ###"
echo -e "##############################${NC}"
echo
cd ${WORKSPACE}
if [ -d "${WORKSPACE}/flow-base-distribution/.git" ]; then
  cd ${WORKSPACE}/flow-base-distribution
  git reset --hard origin/master
  git checkout master
  git pull origin master
else
  git clone https://github.com/neos/flow-base-distribution.git
fi
composer update -d ${WORKSPACE}/flow-base-distribution
