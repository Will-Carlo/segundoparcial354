archivo = "iris.csv"
import pandas as pd

dt = pd.read_csv('C:/Users/ASUS/Documents/umsa - informática/2023 I/01. INF 354/99. 2doParcial254/pregunta 1/Iris.csv')
print(dt.head())
print(dt.info())
print(dt.describe())
print(dt.groupby('Species').size())

import matplotlib.pyplot as plt
