#!/bin/bash

NOW=$(date +%s000)
curl -s -k  \
  -H "Hawkular-Tenant: ${HAWKULAR_TENANT}"       \
  -H "Authorization: Bearer ${HAWKULAR_TOKEN}" \
  -H "Content-Type: application/json" \
  -X POST \
  -d "[{'timestamp': ${NOW}, 'value': 3}]" \
  https://${HAWKULAR_HOST}/hawkular/metrics/gauges/data_x/raw