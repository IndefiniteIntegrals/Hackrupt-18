import os
import argparse
import neural_net
import numpy as np
from pymongo import MongoClient


def getArgs():
	parser = argparse.ArgumentParser(description='this is shit')
	parser.add_argument('-id',type=str,help='this is the unique id of the shitty data that must be fetched into from the database')

	args = parser.parse_args()
	return args.id


uniqueId = getArgs()

client = MongoClient()
db = client['net_data']
table = db.neural
cursor = table.find({'uid' : str(uniqueId)})
print("UniqueId found", uniqueId)
c = None

for doc in cursor:
	c = doc

print(c)

data_point = [[float(c['etpd']), float(c['locpop']), float(c['weektraffic']), float(c['weekdaytraffic']),
	float(c['etsize']), float(c['serviceroutes']), float(c['atminprox']), float(c['ownatm']), float(c['nearatm']),
	float(c['lease']), float(c['mpot']), float(c['comm']), float(c['crimerate']), float(c['servicecost'])]]
data_point = np.array(data_point)

pred = neural_net.predict(data_point)
print(str(uniqueId))
print(pred)
table.update_one({'uid' : str(uniqueId)}, {'$set': {'prediction' : str(pred[0][0])}})
