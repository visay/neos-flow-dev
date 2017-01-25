#!/bin/sh

# Exit with error if a command returns a non-zero status
set -e

DEFAULT_WWW_USER="neos"
DEFAULT_WWW_USER_ID="1000"
DEFAULT_FLOW_CONTEXT="Development"
DEFAULT_NEOS_HOST="neos.dev"
DEFAULT_FLOW_HOST="flow.dev"

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
if [ "${NEOS_HOST}" != "${DEFAULT_NEOS_HOST}" ]; then
	echo "Set Neos hostname to \"${NEOS_HOST}\"!"
	sed -i -e "s~${DEFAULT_NEOS_HOST}~${NEOS_HOST}~g" /etc/nginx/conf.d/neos.conf
fi
if [ "${FLOW_HOST}" != "${DEFAULT_FLOW_HOST}" ]; then
	echo "Set Flow hostname to \"${FLOW_HOST}\"!"
	sed -i -e "s~${DEFAULT_FLOW_HOST}~${FLOW_HOST}~g" /etc/nginx/conf.d/flow.conf
fi

# Update flow context
if [[ -n "${APP_ENV_FLOW_CONTEXT}" ]] && [[ "${APP_ENV_FLOW_CONTEXT}" != "${DEFAULT_FLOW_CONTEXT}" ]]; then
	echo "Set Neos and Flow context to \"${APP_ENV_FLOW_CONTEXT}\" context!"
	sed -i -e "s~FLOW_CONTEXT     ${DEFAULT_FLOW_CONTEXT}~FLOW_CONTEXT     ${APP_ENV_FLOW_CONTEXT}~g" /etc/nginx/conf.d/neos.conf
	sed -i -e "s~FLOW_CONTEXT     ${DEFAULT_FLOW_CONTEXT}~FLOW_CONTEXT     ${APP_ENV_FLOW_CONTEXT}~g" /etc/nginx/conf.d/flow.conf
fi

# Run normal command
exec "$@"
