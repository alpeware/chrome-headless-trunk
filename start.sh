#!/bin/bash

# Run the NSSDB updating utility in background
import_cert.sh $HOME &

CHROME_ARGS="--disable-gpu --headless --no-sandbox --remote-debugging-address=$DEBUG_ADDRESS --remote-debugging-port=$DEBUG_PORT --user-data-dir=/data"

if [ -n "$CHROME_OPTS" ]; then
  CHROME_ARGS="${CHROME_ARGS} ${CHROME_OPTS}"
fi

# Start Chrome
exec sh -c "/usr/bin/google-chrome-unstable $CHROME_ARGS"

