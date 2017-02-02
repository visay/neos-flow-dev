#!/bin/sh

# Exit with error if a command returns a non-zero status
set -e

DEFAULT_WWW_USER="neos"
DEFAULT_WWW_USER_ID="1000"
DEFAULT_FLOW_CONTEXT="Development"
DEFAULT_NEOS_DEV_HOST="neos.dev"
DEFAULT_FLOW_DEV_HOST="flow.dev"
DEFAULT_NEOS_BASE_HOST="neos.base"
DEFAULT_FLOW_BASE_HOST="flow.base"

# Update user name and group name
if [[ -n "${APP_ENV_WWW_USER}" ]] && [[ "${APP_ENV_WWW_USER}" != "${DEFAULT_WWW_USER}" ]]; then
	echo "Rename user ${DEFAULT_WWW_USER} to \"${APP_ENV_WWW_USER}\"!"
	usermod -l ${APP_ENV_WWW_USER} ${DEFAULT_WWW_USER}
	groupmod -n ${APP_ENV_WWW_USER} ${DEFAULT_WWW_USER}
	DEFAULT_WWW_USER="${APP_ENV_WWW_USER}"
fi

# Update user id and group id
if [[ -n "${APP_ENV_WWW_USER_ID}" ]] && [[ "${APP_ENV_WWW_USER_ID}" != "${DEFAULT_WWW_USER_ID}" ]]; then
	echo "Change ${DEFAULT_WWW_USER} user and group ID to \"${APP_ENV_WWW_USER_ID}\"!"
	usermod --uid ${APP_ENV_WWW_USER_ID} ${DEFAULT_WWW_USER}
	groupmod --gid ${APP_ENV_WWW_USER_ID} ${DEFAULT_WWW_USER}
fi

# Update hostname
if [ "${NEOS_DEV_HOST}" != "${DEFAULT_NEOS_DEV_HOST}" ]; then
	echo "Set Neos hostname to \"${NEOS_DEV_HOST}\"!"
	sed -i -e "s~${DEFAULT_NEOS_DEV_HOST}~${NEOS_DEV_HOST}~g" /etc/nginx/conf.d/neos-dev.conf
fi
if [ "${FLOW_DEV_HOST}" != "${DEFAULT_FLOW_DEV_HOST}" ]; then
	echo "Set Flow hostname to \"${FLOW_DEV_HOST}\"!"
	sed -i -e "s~${DEFAULT_FLOW_DEV_HOST}~${FLOW_DEV_HOST}~g" /etc/nginx/conf.d/flow-dev.conf
fi
if [ "${NEOS_BASE_HOST}" != "${DEFAULT_NEOS_BASE_HOST}" ]; then
	echo "Set Neos hostname to \"${NEOS_BASE_HOST}\"!"
	sed -i -e "s~${DEFAULT_NEOS_BASE_HOST}~${NEOS_BASE_HOST}~g" /etc/nginx/conf.d/neos-base.conf
fi
if [ "${FLOW_BASE_HOST}" != "${DEFAULT_FLOW_BASE_HOST}" ]; then
	echo "Set Flow hostname to \"${FLOW_BASE_HOST}\"!"
	sed -i -e "s~${DEFAULT_FLOW_BASE_HOST}~${FLOW_BASE_HOST}~g" /etc/nginx/conf.d/flow-base.conf
fi

# Update flow context
if [[ -n "${APP_ENV_FLOW_CONTEXT}" ]] && [[ "${APP_ENV_FLOW_CONTEXT}" != "${DEFAULT_FLOW_CONTEXT}" ]]; then
	echo "Set Neos and Flow context to \"${APP_ENV_FLOW_CONTEXT}\" context!"
	sed -i -e "s~FLOW_CONTEXT     ${DEFAULT_FLOW_CONTEXT}~FLOW_CONTEXT     ${APP_ENV_FLOW_CONTEXT}~g" /etc/nginx/conf.d/neos-dev.conf
	sed -i -e "s~FLOW_CONTEXT     ${DEFAULT_FLOW_CONTEXT}~FLOW_CONTEXT     ${APP_ENV_FLOW_CONTEXT}~g" /etc/nginx/conf.d/flow-dev.conf
	sed -i -e "s~FLOW_CONTEXT     ${DEFAULT_FLOW_CONTEXT}~FLOW_CONTEXT     ${APP_ENV_FLOW_CONTEXT}~g" /etc/nginx/conf.d/neos-base.conf
	sed -i -e "s~FLOW_CONTEXT     ${DEFAULT_FLOW_CONTEXT}~FLOW_CONTEXT     ${APP_ENV_FLOW_CONTEXT}~g" /etc/nginx/conf.d/flow-base.conf
fi

# Run normal command
exec "$@"
