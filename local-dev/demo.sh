#!/bin/bash

SIM_CARRIER_BINARY='~/git/aetheric/sim-carrier/target/x86_64-unknown-linux-musl/release/sim-carrier'
source .env
BASE_URL="http://0.0.0.0:8099"
TLM_PORT=8012
ATC_PORT=8001
CARGO_PORT=8002

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
# AIRCRAFT=("Marauder")
LATITUDE=52.6379593
LONGITUDE=5.1716790
echo "nickname,uuid,registration,scanner_id" > aircraft.csv
for i in "${!AIRCRAFT[@]}"; do
	a=${AIRCRAFT[$i]}
	REGISTRATION="AETH-CRAFT-$i"

	VERTIPAD_ID=$(curl \
		--request PUT \
		-H "Content-Type: application/json" \
		-d '{
			"vertiport_id": '"$VERTIPORT_ID"',
			"latitude": '"$LATITUDE"',
			"longitude": '"$LONGITUDE"',
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

	# there's no org ids yet, so use a random UUID for it
	SCANNER_ID=$(curl \
		--request PUT \
		-H "Content-Type: application/json" \
		-d '{
			"organization_id": '"$AIRCRAFT_ID"',
			"scanner_type": "underbelly"
		}' \
		$BASE_URL/demo/scanner)

	echo "$a,$AIRCRAFT_ID,$REGISTRATION,$SCANNER_ID" >> aircraft.csv

	sh -c "$SIM_CARRIER_BINARY --uuid $AIRCRAFT_ID --name $REGISTRATION --tlm-port $TLM_PORT --atc-port $ATC_PORT --cargo-port $CARGO_PORT --latitude $LATITUDE --longitude $LONGITUDE --scanner-id $SCANNER_ID" &
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

USER_ID=$(curl \
--request PUT \
-H "Content-Type: application/json" \
-d '{
	"display_name": "John Doe",
	"email": "john@aetheric.nl"
}' \
$BASE_URL/demo/user)

curl \
--request POST \
-H "Content-Type: application/json" \
-d '{
  "origin_vertiport_id": '"$WADDEN_ID"',
  "target_vertiport_id": '"$HOORN_ID"',
  "time_depart_window": {
    "timestamp_min": "2024-04-01T14:00:33+00:00",
    "timestamp_max": "2024-04-01T15:00:33+00:00"
  },
  "time_arrive_window": {
    "timestamp_min": "2024-04-01T14:00:33+00:00",
    "timestamp_max": "2024-04-01T18:00:33+00:00"
  },
  "cargo_weight_g": 200,
  "user_id": '"$USER_ID"'
}' \
http://0.0.0.0:8002/cargo/request > cargo.json

echo "\nUser ID: $USER_ID"