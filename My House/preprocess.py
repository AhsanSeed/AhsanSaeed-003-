"""
    This file contains functions and classes for preprocessing data
    before passing it to the model for training, testing OR predictions
"""

import sklearn
import numpy as np
import pandas as pd
from sklearn.preprocessing import OneHotEncoder as SklearnOneHotEncoder


# Wrapper for one hot encoder to allow labelling of encoded variables
class OneHotEncoder(SklearnOneHotEncoder):
    def __init__(self, **kwargs):
        super(OneHotEncoder, self).__init__(**kwargs)
        self.fit_flag = False

    def fit(self, X, **kwargs):
        out = super().fit(X)
        self.fit_flag = True
        return out

    def transform(self, X, **kwargs):
        sparse_matrix = super(OneHotEncoder, self).transform(X)
        new_columns = self.get_new_columns(X=X)
        d_out = pd.DataFrame(
            sparse_matrix.toarray(), columns=new_columns, index=X.index
        )
        return d_out

    def fit_transform(self, X, **kwargs):
        self.fit(X)
        return self.transform(X)

    def get_new_columns(self, X):
        new_columns = []
        for i, column in enumerate(X.columns):
            j = 0
            while j < len(self.categories_[i]):
                new_columns.append(f"{column}_<{self.categories_[i][j]}>")
                j += 1
        return new_columns



def preprocess_data(data):
    """
        This function takes in raw data from the form and converts it into
        data that is ready for making predictions
    """
    temp = data.copy()
    remove_duplicates(temp)
    check_missing(temp)
    resolve_missing(temp)
    change_types(temp)
    return temp


def check_missing(data):
    pd.options.display.min_rows = 115
    data.isnull().sum().sort_values(ascending=False)
    return


def remove_duplicates(data):
    data.duplicated(subset=None, keep="first")
    return


def resolve_missing(data):
    """
        These missing features can be due to the house 
        lacking these features and hence their value
        is important in determing the price
    """
    missing = [
        "PoolQC",
        "MiscFeature",
        "Alley",
        "Fence",
        "FireplaceQu",
        "LotFrontage",
        "GarageCond",
        "GarageType",
        "GarageYrBlt",
        "GarageFinish",
        "GarageQual",
        "BsmtExposure",
        "BsmtFinType2",
        "BsmtFinType1",
        "BsmtCond",
        "BsmtQual",
        "MasVnrArea",
        "MasVnrType",
        "Electrical",
    ]

    # A map of values that can repsent these missing values
    values = {
        "PoolQC": "No Pool",
        "MiscFeature": "No Feature",
        "Alley": "No alley access",
        "Fence": "No Fence",
        "FireplaceQu": "No Fireplace",
        "GarageCond": "No Garage",
        "GarageType": "No Garage",
        "GarageArea": 0,
        "GarageYrBlt": "None built",
        "GarageFinish": "No Garage",
        "GarageQual": "No Garage",
        "BsmtExposure": "No Basement",
        "BsmtFinType2": "Not Applicable",
        "BsmtFinType1": "Not Applicable",
        "BsmtCond": "No Basement",
        "BsmtQual": "No Basement",
        "MasVnrArea": 0,
        "MasVnrType": "No Veneer",
        "LotFrontage": 0,
    }

    data.fillna(value=values, inplace=True)
    data.isna().sum().sort_values(ascending=False)

    # for other missing categories we will replace with the mode
    features = data.select_dtypes(include=["object"]).columns

    for features in features:
        data[features].fillna(data[features].mode()[0], inplace=True)

    # Sometimes basement values are set to NANs
    Basementmetrics = [
        "BsmtHalfBath",
        "BsmtFullBath",
        "BsmtFinSF1",
        "GarageCars",
        "TotalBsmtSF",
        "BsmtUnfSF",
        "BsmtFinSF2",
    ]

    for Basementmetrics in Basementmetrics:
        data.loc[(data[Basementmetrics].isnull()), Basementmetrics] = 0

    # Missing information on Garage should be replaced
    data.loc[(data.GarageCars.isnull()), "GarageCars"] = 0

    return


def change_types(data):
    """
        Some of the properties of the input data might be better being
        changed for better results during training
    """

    # Year built is currently an integer we should treat this as a
    # category for the purpose of this task
    data.YearBuilt = data.YearBuilt.astype(str)

    data.YrSold = data.YrSold.astype(str)

    data.GarageYrBlt = data.GarageYrBlt.astype(str)

    data.YearRemodAdd = data.YearRemodAdd.astype(str)

    # MSSUbCLass, Overallcond & OverallQual: we will decode this to avoid numeric mix-up
    MSSUbCLass = {
        20: "1-STORY 1946 & NEWER ALL STYLES",
        30: "1-STORY 1945 & OLDER",
        40: "1-STORY W/FINISHED ATTIC ALL AGES",
        45: "1-1/2 STORY - UNFINISHED ALL AGES",
        50: "1-1/2 STORY FINISHED ALL AGES",
        60: "2-STORY 1946 & NEWER",
        70: "2-STORY 1945 & OLDER",
        75: "2-1/2 STORY ALL AGES",
        80: "SPLIT OR MULTI-LEVEL",
        85: "SPLIT FOYER",
        90: "DUPLEX - ALL STYLES AND AGES",
        120: "1-STORY PUD (Planned Unit Development) - 1946 & NEWER",
        150: "1-1/2 STORY PUD - ALL AGES",
        160: "2-STORY PUD - 1946 & NEWER",
        180: "PUD - MULTILEVEL - INCL SPLIT LEV/FOYER",
        190: "2 FAMILY CONVERSION - ALL STYLES AND AGES",
    }

    OverallQualCond = {
        10: "Very Excellent",
        9: "Excellent",
        8: "Very Good",
        7: "Good",
        6: "Above Average",
        5: "Average",
        4: "Below Average",
        3: "Fair",
        2: "Poor",
        1: "Very Poor",
    }

    data.replace(
        {
            "OverallQual": OverallQualCond,
            "OverallCond": OverallQualCond,
            "MSSubClass": MSSUbCLass,
        },
        inplace=True,
    )

    return


def transform(Train, df):

    # isolate categorical features
    cat_columns = df.select_dtypes(include=["object"]).columns
    cat_df = df[cat_columns]

    # isolate the numeric features
    numeric_df = df.select_dtypes(include=np.number)

    # initialise one hot encoder object spcify handle unknown and auto options to keep test and train same size
    ohe = OneHotEncoder(categories="auto", handle_unknown="ignore")
    # Fit the endcoder to training data
    ohe.fit(Train[cat_columns])

    # transform input data
    df_processed = ohe.transform(cat_df)

    # concatinate numeric features from orginal tables with encoded features
    df_processed_full = pd.concat([df_processed, numeric_df], axis=1)

    return df_processed_full



def preprocess_data(data):
    """
        This function takes in raw data from the form and converts it into
        data that is ready for making predictions
    """
    remove_duplicates(data)
    check_missing(data)
    resolve_missing(data)
    change_types(data)

    return