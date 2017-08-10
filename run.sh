#!/bin/sh

set -e

KIBANA_CONF_FILE="/opt/kibana-${KIBANA_VERSION}/config/kibana.yml"

KIBANA_ES_URL=${KIBANA_ES_URL:-http://elasticsearch:9200}
KIBANA_HOST=${KIBANA_HOST:-0.0.0.0}

sed -i "s;.*elasticsearch\.url:.*;elasticsearch\.url: ${KIBANA_ES_URL};" "${KIBANA_CONF_FILE}"
sed -i "s;.*server\.host:.*;server\.host: ${KIBANA_HOST};" "${KIBANA_CONF_FILE}"

if [ -n "${KIBANA_INDEX}" ]; then
    echo "setting index!"
    sed -i "s;.*kibana\.index:.*;kibana\.index: ${KIBANA_INDEX};" "${KIBANA_CONF_FILE}"
fi

# mesos-friendly change
unset HOST
unset PORT

exec /opt/kibana-${KIBANA_VERSION}/bin/kibana
