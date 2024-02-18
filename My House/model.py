import pickle
import preprocess

import numpy as np
import pandas as pd

RandomForestRegressorModel = pickle.load(open('data/models/RandomForestRegressor.pkl', 'rb'))
DecisionTreeRegressorModel = pickle.load(open('data/models/DecisionTreeRegressor.pkl', 'rb'))
GradientBoostingRegressorModel = pickle.load(open('data/models/GradientBoostingRegressor.pkl', 'rb'))

train = pd.read_csv("data/datasets/train_final.csv")

def predict(data, model='GradientBoostingRegressor'):
    data = pd.DataFrame(data)
    test_encode = preprocess.preprocess_data(data)
    test_encode = preprocess.transform(train, data)
    
    if model == 'RandomForestRegressor':
        return np.exp(RandomForestRegressorModel.predict(test_encode))
    
    if model == 'DecisionTreeRegressor':
        return np.exp(DecisionTreeRegressorModel.predict(test_encode))

    if model == 'GradientBoostingRegressor':
        return np.exp(GradientBoostingRegressorModel.predict(test_encode))

    raise Exception(f'{model} was not found')