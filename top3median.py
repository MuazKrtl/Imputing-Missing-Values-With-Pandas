#!/usr/bin/python
# -*- coding: utf-8 -*-

import pandas as pd
import csv
data = pd.read_csv('country_vaccination_stats.csv')

countries = []
dfs = []
medians = [] 
with open('country_vaccination_stats.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0
    for row in csv_reader:
        if line_count != 0:
            if row[0] not in countries:
                countries.append(row[0])
        if line_count == 0:
            line_count += 1 
            

for country in range(len(countries)):
    dfs.append(data[data['country'] == countries[country]]) 
    
for df in dfs:
    medians.append(df["daily_vaccinations"].median())

top3 = sorted(zip(medians,countries), reverse=True)[:3]

for item in top3:
	print(item)

