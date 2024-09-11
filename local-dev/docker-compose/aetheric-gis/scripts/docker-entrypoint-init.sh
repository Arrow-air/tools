#!/bin/bash
if [[ -f "$PGDATA/init_done" ]]
then
	# Init not needed
	exit 0
fi

# Start docker entry point to trigger init steps
/usr/local/bin/docker-entrypoint.sh postgres &

# Wait till init scripts completed
# We can test this by calling one of the functions being created by our init script.
touch "$PGDATA/init_done"
