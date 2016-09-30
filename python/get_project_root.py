#! /usr/bin/env python3
import os, datetime

current_path=os.getcwd()
server_base="/Volumes/pegasus/01_PROJECTS/"
reviews_base="10_Review/"

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

def get_project_base():
    project_base=current_path.split("/")[4]
    return project_base

def is_project():
    result = current_path.find(server_base) == 0
    return result
    
def create_todays_review_folder():
    
    tentative_path = server_base + get_project_base() + os.sep + reviews_base + get_timestamp()    
    
    if not os.path.exists(tentative_path):
        #os.makedirs(tentative_path)
        print('folder_created at : '+ tentative_path)
    else:
        print('folder already exists')
        
    return

print(create_todays_review_folder())
