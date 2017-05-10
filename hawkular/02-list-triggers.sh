#!/bin/bash

curl -k -s \
  -H "Hawkular-Tenant: ${HAWKULAR_TENANT}" \
  -H "Authorization: Bearer ${HAWKULAR_TOKEN}" \
  -H "Content-Type: application/json" \
  https://${HAWKULAR_HOST}/hawkular/alerts/export | jq .
