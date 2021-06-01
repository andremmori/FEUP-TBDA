import json
import os

from dotenv import load_dotenv
from pymongo import MongoClient

load_dotenv()


def parse_data(table_name: str):
    return json.loads(open("data/%s_DATA.json" % table_name).read())['results'][0]['items']


def main():
    # Parse db server data from .env
    db_server = 'mongodb://{}@{}'.format(os.getenv('DB_AUTH'),
                                        os.getenv('DB_HOST'))
    # Init client and DB
    client = MongoClient(db_server)
    db = client['tbdg']

    # Drop collections
    db.facilities.drop()

    # Parse exported data from SQL db
    activities = parse_data('ACTIVITIES')
    districts = parse_data('DISTRICTS')
    facilities = parse_data('FACILITIES')
    municipalities = parse_data('MUNICIPALITIES')
    regions = parse_data('REGIONS')
    roomtypes = parse_data('ROOMTYPES')
    uses = parse_data('USES')


    # Regions
    for region in regions:
        region['_id'] = region['cod']
        del region['cod']

    # Districts
    for district in districts:
        district['_id'] = district['cod']
        del district['cod']

        if(district['region'] == ''):
            continue
        region = next(
            reg for reg in regions if reg['_id'] == district['region'])
        district['region'] = region

    # Municipalities
    for municipality in municipalities:
        municipality['_id'] = municipality['cod']
        del municipality['cod']

        district = next(
            dist for dist in districts if dist['_id'] == municipality['district'])
        region = next(
            reg for reg in regions if reg['_id'] == municipality['region'])
        municipality['district'] = district
        municipality['region'] = region

    # Facilities
    for facility in facilities:
        facility['_id'] = facility['id']
        del facility['id']

        roomtype = next(
            room for room in roomtypes if room['roomtype'] == facility['roomtype'])
        facility['roomtype'] = roomtype['description']

        municipality = next(
            mun for mun in municipalities if mun['_id'] == facility['municipality'])
        facility['municipality'] = municipality
        facility['activities'] = []

    # Add activities to facilities
    for use in uses:
        facility = next(fac for fac in facilities if fac['_id'] == use['id'])
        activity = next(act for act in activities if act['ref'] == use['ref'])
        facility['activities'].append(activity['activity'])

    # Insert data into MongoDB
    db['facilities'].insert_many(facilities)


if __name__ == "__main__":
    main()


