import os
import argparse
import neural_net_loan
import numpy as np
from pymongo import MongoClient


def getArgs():
	parser = argparse.ArgumentParser(description='this is shit')
	parser.add_argument('-id',type=str, help='this is the unique id of the shitty data that must be fetched into from the database')

	args = parser.parse_args()
	return args.id


uniqueId = getArgs()

client = MongoClient()
db = client['net_data']
table = db.neural_loan
cursor = table.find({'uid' : str(uniqueId)})
print("UniqueId found", uniqueId)
c = None

for doc in cursor:
	c = doc

print(c)

data_point = [[float(c['Gender']),
	float(c['Dob']),
	float(c['PIN']),
	float(c['Curr_res_yr']),
	float(c['Curr_res']),
	float(c['Rent']), float(c['Deps']), float(c['Marital']), float(c['Qualification']), float(c['Credit_score']),
	float(c['Religion']),
	float(c['Category']),
	float(c['Res_stat']),
	float(c['Occupation']),
	float(c['Salaried']),
	float(c['Emp_pin']),
	float(c['Curr_emp_yr']),
	float(c['Gross_monthly_in']),
	float(c['Net_monthly_in']),
	float(c['Avg_monthly_exp']),
	float(c['Prop']),
	float(c['Veh']),
	float(c['FD']), float(c['PPF']), float(c['PF']),
	float(c['Investments']), float(c['SLIP']), float(c['Amt']), float(c['Tenor'])]]
data_point = np.array(data_point)

pred = neural_net_loan.predict(data_point)
print(str(uniqueId))
print(pred)
table.update_one({'uid' : str(uniqueId)}, {'$set': {'prediction' : str(pred[0][0])}})
