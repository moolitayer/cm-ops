# Trigger
curl -k -s \
    -H "Hawkular-Tenant: $HAWKULAR_TENANT" \
    -H "Authorization: Bearer $HAWKULAR_TOKEN" \
    -X DELETE \
    https://$HAWKULAR_HOST/hawkular/alerts/triggers/ops-example| jq .

# Alerts
curl -k -s \
    -H "Hawkular-Tenant: $HAWKULAR_TENANT" \
    -H "Authorization: Bearer $HAWKULAR_TOKEN" \
    -X PUT \
    https://$HAWKULAR_HOST/hawkular/alerts/delete?tags="nodename|vm-48-124.eng.lab.tlv.redhat.com"

# events
curl -k -s \
    -H "Hawkular-Tenant: $HAWKULAR_TENANT" \
    -H "Authorization: Bearer $HAWKULAR_TOKEN" \
    -X PUT \
    https://$HAWKULAR_HOST/hawkular/alerts/events/delete?tags="nodename|vm-48-124.eng.lab.tlv.redhat.com"
