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
while ! psql -U svc_gis -d gis -c 'SELECT * FROM arrow.available_routes(1, 1, NOW(), NOW());'
do
	sleep 2
done
touch "$PGDATA/init_done"
