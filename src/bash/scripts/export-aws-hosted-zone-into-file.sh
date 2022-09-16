#!/bin/bash
# usage: 
# bash src/bash/scripts/export-aws-hosted-zone-into-file.sh flok.fi > cnf/dns/flok.fi.bind
# bash src/bash/scripts/export-aws-hosted-zone-into-file.sh aws.spectralengines.com > cnf/dns/aws.spectralengines.com.bind

zonename=$1
hostedzoneid=Z0976114G00ICPCW2Z2S
# hostedzoneid=$(aws route53 list-hosted-zones --output json | jq -r ".HostedZones[] | select(.Name == \"$zonename.\") | .Id" | cut -d'/' -f3)
aws route53 list-resource-record-sets --hosted-zone-id $hostedzoneid --output json | jq -jr '.ResourceRecordSets[] | "\(.Name) \t\(.TTL) \t\(.Type) \t\(.ResourceRecords[]?.Value)\n"'
