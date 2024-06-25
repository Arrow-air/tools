#!/bin/python3

import requests
import os
from shapely.geometry import Polygon
import pointpats
import uuid
import randomname
import shutil
import argparse

ASSETS_PORT=os.environ.get('ASSETS_HOST_PORT_REST')
ITEST_PORT=os.environ.get('ITEST_HOST_PORT_REST')
ASSETS_URL=f"http://0.0.0.0:{ASSETS_PORT}/assets"
ITEST_URL=f"http://0.0.0.0:{ITEST_PORT}"

def random_coord_within_boundary(boundary):
	coords = []
	for coordinate in boundary:
		coords.append([coordinate['longitude'], coordinate['latitude']])

	pgon = Polygon(coords)
	point = pointpats.random.poisson(pgon, size=1)
	return [point.item(0), point.item(1)]

def add_vertipad(vertiport_id, longitude, latitude, count):
	vertipad_id = requests.put(ITEST_URL + '/demo/vertipad', json={
		"vertiport_id": vertiport_id,
		"latitude": latitude,
		"longitude": longitude,
		"altitude": 0.0,
		"label": f"pad-{count}"
	}).json()
	
	print(vertipad_id)
	return vertipad_id

def add_scanner():
	scanner_id = requests.put(ITEST_URL + '/demo/scanner', json={
		"organization_id": str(uuid.uuid4()),
		"scanner_type": "underbelly"
	}).json()

	return scanner_id

def add_aircraft(registration, vertiport_id, vertipad_id):
	aircraft_id = requests.put(ITEST_URL + '/demo/aircraft', json={
		"registration_number": registration,
		"hangar_id": vertiport_id,
		"hangar_bay_id": vertipad_id,
		"nickname": randomname.get_name(adj=('speed'), noun=('birds'))
	}).json()

	return aircraft_id

def populate_aircraft(vertiport_id, hangar_count, boundary, sim_binary):
	aircraft_count=5
	for i in range(aircraft_count):
		j=hangar_count*20 + i
		registration="AETH-CRAFT-" + str(j)

		(longitude, latitude)=random_coord_within_boundary(boundary)
		vertipad_id=add_vertipad(vertiport_id, longitude, latitude, i)
		scanner_id=add_scanner()
		aircraft_id=add_aircraft(registration, vertiport_id, vertipad_id)
		print(f'Registration: {registration}, Vertiport ID: {vertiport_id}, Vertipad ID: {vertipad_id}, Scanner ID: {scanner_id}')

		if sim_binary and shutil.which(sim_binary):
			os.system(f"{sim_binary} \
				--uuid {aircraft_id} \
				--name {registration} \
				--scanner-id {scanner_id} \
				--longitude {longitude} \
				--latitude {latitude} \
			&")

if __name__ == "__main__":
	response = requests.get(ASSETS_URL + '/demo/vertiports').json()
	hangar_count=0

	parser=argparse.ArgumentParser(prog='attach-aircraft-sim.py', description='Attach aircraft to vertiports')
	parser.add_argument('-s', '--sim', help='Path to the sim carrier binary')
	args = parser.parse_args()

	if not ASSETS_PORT or not ITEST_PORT:
		print("Please set ASSETS_HOST_PORT_REST and ITEST_HOST_PORT_REST environment variables")
		exit(1)

	for (hangar_count, vertiport) in enumerate(response):
		if "Hangar" in vertiport['basics']['name']:
			print(vertiport['basics']['name'])
			boundary = vertiport['geo_location']['exterior']['points']
			vertiport_id = vertiport['basics']['id']
			populate_aircraft(vertiport_id, hangar_count, boundary, args.sim)
