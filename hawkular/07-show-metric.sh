#!/bin/bash

curl -k -s \
    -H "Hawkular-Tenant: $HAWKULAR_TENANT" \
    -H "Authorization: Bearer $HAWKULAR_TOKEN" \
    https://$HAWKULAR_HOST/hawkular/metrics/gauges/data_x/raw?start=0 | jq .
