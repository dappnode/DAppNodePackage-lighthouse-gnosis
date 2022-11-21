#!/bin/bash

# Concatenate EXTRA_OPTS string
[[ -n "$CHECKPOINT_SYNC_URL" ]] && EXTRA_OPTS="${EXTRA_OPTS} --checkpoint-sync-url=${CHECKPOINT_SYNC_URL}"

case $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_GNOSIS in
"nethermind-gnosis.dappnode.eth")
  HTTP_ENGINE="http://nethermind-gnosis.dappnode:8551"
  ;;
"erigon-gnosis.dnp.dappnode.eth")
  HTTP_ENGINE="http://erigon-gnosis.dappnode:8551"
  ;;
*)
  echo "Unknown value for _DAPPNODE_GLOBAL_EXECUTION_CLIENT_GNOSIS: $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_GNOSIS"
  HTTP_ENGINE=$_DAPPNODE_GLOBAL_EXECUTION_CLIENT_GNOSIS
  ;;
esac

exec lighthouse \
    --debug-level $DEBUG_LEVEL \
    --network gnosis \
    beacon_node \
    --datadir /root/.lighthouse \
    --eth1 --eth1-endpoints $HTTP_WEB3PROVIDER \
    --http \
    --http-allow-origin "*" \
    --http-address 0.0.0.0 \
    --http-port $BEACON_API_PORT \
    --port $P2P_PORT \
    --metrics \
    --metrics-address 0.0.0.0 \
    --metrics-port 8008 \
    --metrics-allow-origin "*" \
    --execution-endpoint $HTTP_ENGINE \
    --execution-jwt "/jwtsecret" \
    $EXTRA_OPTS
