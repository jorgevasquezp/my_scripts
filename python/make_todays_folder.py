#!/usr/bin/python
# Creates a timestamp for today, and checks if a folder of that description exists, if id doesn't it creates it.
import os, datetime
def get_timestamp():
	today = datetime.date.today()
	curr_year = str(today.year)[2:4]
	curr_month = str(today.month)
	curr_day = str(today.day)
	if len(curr_month) < 2 :
		curr_month = '0' + curr_month
	if len(curr_day) < 2 :
		curr_day = '0' + curr_day
		
	time_stamp = curr_month + curr_day + curr_year
	return time_stamp


tentative_path = os.getcwd() + os.sep + get_timestamp()


if not os.path.exists(tentative_path):
	os.mkdir(tentative_path)
	print('folder_created at : '+ tentative_path)
else:
	print('folder already exists')
