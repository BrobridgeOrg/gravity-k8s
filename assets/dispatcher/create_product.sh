#!/bin/sh

# create data prodcut
/gravity-cli product create accounts --desc="e2etest" --enabled \
    --schema=/assets/assets/dispatcher/schema_test.json \
    -s "nats-jetstream.default.svc.cluster.local:32803"
if [ $$? -ne 0 ]; then
    echo "@@ Failed to create product !!!"
else
    echo "## Product has been created."
fi
# create product ruleset
## accountCreated
/gravity-cli product ruleset add accounts accountCreated --enabled \
    --event=accountCreated --method=create \
    --handler=/assets/assets/dispatcher/handler_test.js \
    --schema=/assets/assets/dispatcher/schema_test.json \
    -s "nats-jetstream.default.svc.cluster.local:32803"
if [ $$? -ne 0 ]; then
    echo "@@ Failed to create product ruleset 'accountCreated' !!!"
else
    echo "## Product ruleset 'accountCreated' has been created."
fi

## accountDeleted
/gravity-cli product ruleset add accounts accountDeleted --enabled \
    --event=accountDeleted --method=delete \
    --handler=/assets/assets/dispatcher/handler_test.js \
    --schema=/assets/assets/dispatcher/schema_test.json \
    -s "nats-jetstream.default.svc.cluster.local:32803"
if [ $$? -ne 0 ]; then
    echo "@@ Failed to create product ruleset 'accountDeleted' !!!"
else
    echo "## Product ruleset 'accountDeleted' has been created."
fi