#!/bin/bash

SIM_CARRIER_BINARY='~/git/aetheric/sim-carrier/target/x86_64-unknown-linux-musl/release/sim-carrier'
source .env
BASE_URL="http://0.0.0.0:8099"
TLM_PORT=8012
ATC_PORT=8001
CARGO_PORT=8002

# echo "Running Population for $BASE_URL..."
#
# attach aircraft script will add aircraft to this hangar
HOORN_HANGAR_ID=$(curl \
	--request PUT \
	-H "Content-Type: application/json" \
	-d '{
		"label": "Hoorn Hangar #1",
		"address": "Het Wuiver 2B, 1608 ES Wijdenes",
		"vertices": [
			[52.6387406, 5.1693605],
			[52.6391572, 5.1751138],
			[52.6366050, 5.1759725],
			[52.6357195, 5.1696181],
			[52.6387406, 5.1693605]
		],
		"altitude": 0.0
	}' \
	$BASE_URL/demo/vertiport
)

if [ -z "$HOORN_HANGAR_ID" ]; then
	echo "Failed to create vertiport"
	exit 1
fi

#
# KATWOUDE HANGAR
#
# attach aircraft script will add aircraft to this hangar
KATWOUDE_HANGAR_ID=$(curl \
--request PUT \
-H "Content-Type: application/json" \
-d '{
	"label": "Katwoude Hangar #1",
	"address": "Katwoude",
	"vertices": [
		[52.4688086, 5.0676924],
		[52.4687384, 5.0681566],
		[52.4690063, 5.0683123],
		[52.4690750, 5.0678641],
		[52.4688086, 5.0676924]
	],
	"altitude": 11.0
}' \
$BASE_URL/demo/vertiport)

#
# HOORN
#
HOORN_ID=$(curl \
--request PUT \
-H "Content-Type: application/json" \
-d '{
	"label": "Hoorn Private #1",
	"address": "Westerdijk 52, 1621 LE Hoorn",
	"vertices": [
		[52.6487268, 4.9891228],
		[52.6480889, 4.9892300],
		[52.6481410, 4.9901310],
		[52.6487528, 4.9900881],
		[52.6487268, 4.9891228]
	],
	"altitude": 10.0
}' \
$BASE_URL/demo/vertiport)

curl \
--request PUT \
-H "Content-Type: application/json" \
-d '{
	"vertiport_id": '"$HOORN_ID"',
	"latitude": 52.6484013,
	"longitude": 4.9897020,
	"altitude": 10.1,
	"label": "pad-1"
}' \
$BASE_URL/demo/vertipad

#
# ALMERE
#
ALMERE_ID=$(curl \
--request PUT \
-H "Content-Type: application/json" \
-d '{
	"label": "Almere #1",
	"address": "Galjootweg, Almere",
	"vertices": [
		[52.3813888, 5.1486600],
		[52.3802624, 5.1496045],
		[52.3809697, 5.1516225],
		[52.3818603, 5.1507638],
		[52.3813888, 5.1486600]
	],
	"altitude": 10.0
}' \
$BASE_URL/demo/vertiport)

curl \
--request PUT \
-H "Content-Type: application/json" \
-d '{
	"vertiport_id": '"$ALMERE_ID"',
	"latitude": 52.3811268,
	"longitude": 5.1500768,
	"altitude": 11.2,
	"label": "pad-1"
}' \
$BASE_URL/demo/vertipad

#
# ENKHUIZEN
#
ENKHUIZEN_ID=$(curl \
--request PUT \
-H "Content-Type: application/json" \
-d '{
	"label": "Enkhuizen #1",
	"address": "Kruitmolen, 1601 MC Enkhuizen",
	"vertices": [
		[52.6890066, 5.2613696],
		[52.6882717, 5.2613267],
		[52.6882717, 5.2625181],
		[52.6890131, 5.2625825],
		[52.6890066, 5.2613696]
	],
	"altitude": 10.0
}' \
$BASE_URL/demo/vertiport)

curl \
--request PUT \
-H "Content-Type: application/json" \
-d '{
	"vertiport_id": '"$ENKHUIZEN_ID"',
	"latitude": 52.6886359,
	"longitude": 5.2618564,
	"altitude": 11.2,
	"label": "pad-1"
}' \
$BASE_URL/demo/vertipad

#
# MARKEN
#
MARKEN_ID=$(curl \
--request PUT \
-H "Content-Type: application/json" \
-d '{
	"label": "Marken #1",
	"address": "Kruisbaakweg 6",
	"vertices": [
		[52.4540709, 5.1013584],
		[52.4539826, 5.1014819],
		[52.4540529, 5.1016563],
		[52.4541428, 5.1015382],
		[52.4540709, 5.1013584]
	],
	"altitude": 10.0
}' \
$BASE_URL/demo/vertiport)

curl \
--request PUT \
-H "Content-Type: application/json" \
-d '{
	"vertiport_id": '"$MARKEN_ID"',
	"latitude": 52.4540607,
	"longitude": 5.1014988,
	"altitude": 11.2,
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
	"address": "Oostvaardersdijk 113, 8242 PA Lelystad",
	"vertices": [
		[52.5841430, 5.3645049],
		[52.5840615, 5.3645062],
		[52.5840607, 5.3646658],
		[52.5841463, 5.3646684],
		[52.5841430, 5.3645049]
	],
	"altitude": 11.0
}' \
$BASE_URL/demo/vertiport)

curl \
--request PUT \
-H "Content-Type: application/json" \
-d '{
	"vertiport_id": '"$WADDEN_ID"',
	"latitude": 52.5841015,
	"longitude": 5.3645814,
	"altitude": 11.2,
	"label": "pad-1"
}' \
$BASE_URL/demo/vertipad

USER_ID=$(curl \
--request PUT \
-H "Content-Type: application/json" \
-d '{
	"display_name": "Alex Smith",
	"email": "alex@aetheric.nl"
}' \
$BASE_URL/demo/user)

echo "
  \"user_id\": $USER_ID,
  \"origin_vertiport_id\": $WADDEN_ID,
  \"target_vertiport_id\": $HOORN_ID,
"
