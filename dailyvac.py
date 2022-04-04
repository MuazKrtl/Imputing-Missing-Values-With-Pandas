#!/usr/bin/python
# -*- coding: utf-8 -*-

import pandas as pd
import csv
data = pd.read_csv('country_vaccination_stats.csv')

countries = []
dfs = []
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
    if df.shape[0] == 1:
        df["daily_vaccinations"] = df["daily_vaccinations"].fillna(0)
    else:
        df["daily_vaccinations"] = df["daily_vaccinations"].fillna(df["daily_vaccinations"].min())

dataframe = pd.concat(dfs)
dailysum = dataframe.loc[dataframe['date'] == "1/6/2021","daily_vaccinations"].sum()
print(dailysum)


