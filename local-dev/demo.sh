#!/bin/bash
source .env
BASE_URL="http://0.0.0.0:8014"
# echo "Running Population for $BASE_URL..."

VERTIPORT_ID=$(curl \
	--request PUT \
	-H "Content-Type: application/json" \
	-d '{
		"label": "Hoorn Hangar #1",
		"vertices": [
			[52.6387406, 5.1693605],
			[52.6391572, 5.1751138],
			[52.6366050, 5.1759725],
			[52.6357195, 5.1696181],
			[52.6387406, 5.1693605]
		]
	}' \
	$BASE_URL/demo/vertiport
)

if [ -z "$VERTIPORT_ID" ]; then
	echo "Failed to create vertiport"
	exit 1
fi

echo "Vertiport ID: $VERTIPORT_ID"

AIRCRAFT=("Marauder" "Mantis" "Ghost" "RazorCrest")

echo "nickname,uuid,registration_number" > aircraft.csv
for i in "${!AIRCRAFT[@]}"; do
	a=${AIRCRAFT[$i]}
	REGISTRATION="AETH-CRAFT-$i"

	VERTIPAD_ID=$(curl \
		--request PUT \
		-H "Content-Type: application/json" \
		-d '{
			"vertiport_id": '"$VERTIPORT_ID"',
			"latitude": 52.6379593,
			"longitude": 5.1716790,
			"label": "pad-'"$i"'"
		}' \
		$BASE_URL/demo/vertipad
	)

	AIRCRAFT_ID=$(curl \
	-q \
	-X PUT -H "Content-Type: application/json" \
	-d '{
		"nickname": "'"$a"'",
		"registration_number": "'"$REGISTRATION"'",
		"hangar_id": '"$VERTIPORT_ID"',
		"hangar_bay_id": '"$VERTIPAD_ID"'
	}' \
	http://0.0.0.0:$ITEST_HOST_PORT_REST/demo/aircraft)

	echo "$a,$AIRCRAFT_ID,$REGISTRATION" >> aircraft.csv
done

#
# HOORN
#
HOORN_ID=$(curl \
--request PUT \
-H "Content-Type: application/json" \
-d '{
	"label": "Hoorn Private #1",
	"vertices": [
		[52.6487268, 4.9891228],
		[52.6480889, 4.9892300],
		[52.6481410, 4.9901310],
		[52.6487528, 4.9900881],
		[52.6487268, 4.9891228]
	]
}' \
$BASE_URL/demo/vertiport)

curl \
--request PUT \
-H "Content-Type: application/json" \
-d '{
	"vertiport_id": '"$HOORN_ID"',
	"latitude": 52.6484013,
	"longitude": 4.9897020,
	"label": "pad-1"
}' \
$BASE_URL/demo/vertipad

#
# MARKER WADDEN
#
WADDEN_ID=$(curl \
--request PUT \
-H "Content-Type: application/json" \
-d '{
	"label": "Marker Wadden Private #1",
	"vertices": [
		[52.5841430, 5.3645049],
		[52.5840615, 5.3645062],
		[52.5840607, 5.3646658],
		[52.5841463, 5.3646684],
		[52.5841430, 5.3645049]
	]
}' \
$BASE_URL/demo/vertiport)

curl \
--request PUT \
-H "Content-Type: application/json" \
-d '{
	"vertiport_id": '"$WADDEN_ID"',
	"latitude": 52.5841015,
	"longitude": 5.3645814,
	"label": "pad-1"
}' \
$BASE_URL/demo/vertipad
