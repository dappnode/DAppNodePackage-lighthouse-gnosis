#!/bin/bash

# Concatenate EXTRA_OPTS string
[[ -n "$CHECKPOINT_SYNC_URL" ]] && EXTRA_OPTS="${EXTRA_OPTS} --checkpoint-sync-url=${CHECKPOINT_SYNC_URL}"

case $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_GNOSIS in
"nethermind-xdai.dnp.dappnode.eth")
  HTTP_ENGINE="http://nethermind-xdai.dappnode:8551"
  ;;
"erigon-gnosis.dnp.dappnode.eth")
  HTTP_ENGINE="http://erigon-gnosis.dappnode:8551"
  ;;
*)
  echo "Unknown value for _DAPPNODE_GLOBAL_EXECUTION_CLIENT_GNOSIS: $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_GNOSIS"
  # TODO: this default value must be temporary and changed once there are mor than 1 EC
  HTTP_ENGINE="http://nethermind-xdai.dappnode:8551"
  ;;
esac

exec lighthouse \
    --debug-level $DEBUG_LEVEL \
    --network gnosis \
    beacon_node \
    --datadir /root/.lighthouse \
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
