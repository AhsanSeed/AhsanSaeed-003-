
features_list = [
    'MSSubClass',
    'MSZoning',
    'LotFrontage',
    'LotArea',
    'Street',
    'Alley',
    'LotShape',
    'LandContour',
    'Utilities',
    'LotConfig',
    'LandSlope',
    'Neighborhood',
    'Condition1',
    'Condition2',
    'BldgType',
    'HouseStyle',
    'OverallQual',
    'OverallCond',
    'YearBuilt',
    'YearRemodAdd',
    'RoofStyle',
    'RoofMatl',
    'Exterior1st',
    'Exterior2nd',
    'MasVnrType',
    'MasVnrArea',
    'ExterQual',
    'ExterCond',
    'Foundation',
    'BsmtQual',
    'BsmtCond',
    'BsmtExposure',
    'BsmtFinType1',
    'BsmtFinSF1',
    'BsmtFinType2',
    'BsmtFinSF2',
    'BsmtUnfSF',
    'TotalBsmtSF',
    'Heating',
    'HeatingQC',
    'CentralAir',
    'Electrical',
    '1stFlrSF',
    '2ndFlrSF',
    'LowQualFinSF',
    'GrLivArea',
    'BsmtFullBath',
    'BsmtHalfBath',
    'FullBath',
    'HalfBath',
    'Bedroom',
    'Kitchen',
    'KitchenQual',
    'TotRmsAbvGrd',
    'Functional',
    'Fireplaces',
    'FireplaceQu',
    'GarageType',
    'GarageYrBlt',
    'GarageFinish',
    'GarageCars',
    'GarageArea',
    'GarageQual',
    'GarageCond',
    'PavedDrive',
    'WoodDeckSF',
    'OpenPorchSF',
    'EnclosedPorch',
    '3SsnPorch',
    'ScreenPorch',
    'PoolArea',
    'PoolQC',
    'Fence',
    'MiscFeature',
    'MiscVal',
    'MoSold',
    'YrSold',
    'SaleType',
    'SaleCondition',
]


feature_form_structure = {
    'General': [
        {
            'Label': 'MSSubClass',
            'Data' :  {
                'Description': 'Identifies the type of dwelling involved in the sale.',
                'Form': {
                    '20':	'1-STORY 1946 & NEWER ALL STYLES',
                    '30':	'1-STORY 1945 & OLDER',
                    '40':	'1-STORY W/FINISHED ATTIC ALL AGES',
                    '45':	'1-1/2 STORY - UNFINISHED ALL AGES',
                    '50':	'1-1/2 STORY FINISHED ALL AGES',
                    '60':	'2-STORY 1946 & NEWER',
                    '70':	'2-STORY 1945 & OLDER',
                    '75':	'2-1/2 STORY ALL AGES',
                    '80':	'SPLIT OR MULTI-LEVEL',
                    '85':	'SPLIT FOYER',
                    '90':	'DUPLEX - ALL STYLES AND AGES',
                    '120':	'1-STORY PUD (Planned Unit Development) - 1946 & NEWER',
                    '150':	'1-1/2 STORY PUD - ALL AGES',
                    '160':	'2-STORY PUD - 1946 & NEWER',
                    '180':	'PUD - MULTILEVEL - INCL SPLIT LEV/FOYER',
                    '190':	'2 FAMILY CONVERSION - ALL STYLES AND AGES',
                }
            }
        },
        {
            'Label': 'MSZoning',
            'Data' :  {
                'Description': 'Identifies the general zoning classification of the sale.',
                'Form': {
                    'A':	'Agriculture',
                    'C':	'Commercial',
                    'FV':	'Floating Village Residential',
                    'I':	'Industrial',
                    'RH':	'Residential High Density',
                    'RL':	'Residential Low Density',
                    'RP':	'Residential Low Density Park ',
                    'RM':	'Residential Medium Density',
                }
            }
        },
        {
            'Label': 'LotFrontage',
            'Data' :  {
                'Description': 'Linear feet of street connected to property',
                'Form': 'float64',
            }
        },
        {
            'Label': 'LotArea',
            'Data' :  {
                'Description': 'Lot size in square feet',
                'Form': 'float64'
            },
        },
        {
            'Label': 'Street',
            'Data' :  {
                'Description': 'Type of road access to property',
                'Form': {
                    'Grvl':	'Gravel',
                    'Pave':	'Paved',
                }
            },
        },
        {
            'Label': 'Alley',
            'Data' :  {
                'Description': 'Type of alley access to property',
                'Form': {
                    'Grvl':	'Gravel',
                    'Pave':	'Paved',
                    'NA': 	'No alley access',
                }
            }
        },
        {
            'Label': 'LotShape',
            'Data' :  {
                'Description': 'General shape of property',
                'Form': {
                    'Reg':	'Regular',
                    'IR1':	'Slightly irregular',
                    'IR2':	'Moderately Irregular',
                    'IR3':	'Irregular',
                }
            }
        },
        {
            'Label': 'LandContour',
            'Data' :  {
                'Description': 'Flatness of the property',
                'Form': {
                    'Lvl':	'Near Flat/Level',
                    'Bnk':	'Banked - Quick and significant rise from street grade to building',
                    'HLS':	'Hillside - Significant slope from side to side',
                    'Low':	'Depression',
                },
            }
        },
        {
            'Label': 'Utilities',
            'Data' :  {
                'Description': 'Type of utilities available',
                'Form': {
                    'AllPub':	'All public Utilities (E,G,W,& S)',
                    'NoSewr':	'Electricity, Gas, and Water (Septic Tank)',
                    'NoSeWa':	'Electricity and Gas Only',
                    'ELO':	'Electricity only',
                }
            }
        },
        {
            'Label': 'LotConfig',
            'Data' :  {
                'Description': 'Lot configuration',
                'Form': {
                    'Inside':	'Inside lot',
                    'Corner':	'Corner lot',
                    'CulDSac':	'Cul-de-sac',
                    'FR2':	'Frontage on 2 sides of property',
                    'FR3':	'Frontage on 3 sides of property',
                }
            }
        },
        {
            'Label': 'LandSlope',
            'Data' :  {
                'Description': 'Slope of property',
                'Form': {
                    'Gtl':	'Gentle slope',
                    'Mod':	'Moderate Slope	',
                    'Sev':	'Severe Slope',
                }
            }
        },
        {
            'Label': 'Neighborhood',
            'Data' :  {
                'Description': 'Physical locations within Ames city limits',
                'Form': {
                    'Blmngtn':	'Bloomington Heights',
                    'Blueste':	'Bluestem',
                    'BrDale':	'Briardale',
                    'BrkSide':	'Brookside',
                    'ClearCr':	'Clear Creek',
                    'CollgCr':	'College Creek',
                    'Crawfor':	'Crawford',
                    'Edwards':	'Edwards',
                    'Gilbert':	'Gilbert',
                    'IDOTRR':	'Iowa DOT and Rail Road',
                    'MeadowV':	'Meadow Village',
                    'Mitchel':	'Mitchell',
                    'Names':	'North Ames',
                    'NoRidge':	'Northridge',
                    'NPkVill':	'Northpark Villa',
                    'NridgHt':	'Northridge Heights',
                    'NWAmes':	'Northwest Ames',
                    'OldTown':	'Old Town',
                    'SWISU':	'South & West of Iowa State University',
                    'Sawyer':	'Sawyer',
                    'SawyerW':	'Sawyer West',
                    'Somerst':	'Somerset',
                    'StoneBr':	'Stone Brook',
                    'Timber':	'Timberland',
                    'Veenker':	'Veenker',
                }
            }
        },
        {
            'Label': 'Condition1',
            'Data' :  {
                'Description': 'Proximity to various conditions',
                'Form': {
                    'Artery':	'Adjacent to arterial street',
                    'Feedr':	'Adjacent to feeder street',
                    'Norm':	'Normal	',
                    'RRNn':	"Within 200' of North-South Railroad",
                    'RRAn':	'Adjacent to North-South Railroad',
                    'PosN':	'Near positive off-site feature--park, greenbelt, etc.',
                    'PosA':	'Adjacent to postive off-site feature',
                    'RRNe':	"Within 200' of East-West Railroad",
                    'RRAe':	'Adjacent to East-West Railroad',
                }
            }
        },
        {
            'Label': 'Condition2',
            'Data' :  {
                'Description': 'Proximity to various conditions (if more than one is present)',
                'Form': {
                    'Artery':	'Adjacent to arterial street',
                    'Feedr':	'Adjacent to feeder street',
                    'Norm':	'Normal	',
                    'RRNn':	"Within 200' of North-South Railroad",
                    'RRAn':	'Adjacent to North-South Railroad',
                    'PosN':	'Near positive off-site feature--park, greenbelt, etc.',
                    'PosA':	'Adjacent to postive off-site feature',
                    'RRNe':	"Within 200' of East-West Railroad",
                    'RRAe':	'Adjacent to East-West Railroad',
                }
            }
        },
        {
            'Label': 'Functional',
            'Data' :  {
                'Description': 'Home functionality (Assume typical unless deductions are warranted)',
                'Form': {
                    'Typ':	'Typical Functionality',
                    'Min1':	'Minor Deductions 1',
                    'Min2':	'Minor Deductions 2',
                    'Mod':	'Moderate Deductions',
                    'Maj1':	'Major Deductions 1',
                    'Maj2':	'Major Deductions 2',
                    'Sev':	'Severely Damaged',
                    'Sal':	'Salvage only',
                }
            }
        },
    ],
    'Construction': [
        {
            'Label': 'BldgType',
            'Data' :  {
                'Description': 'Type of dwelling',
                'Form': {
                    '1Fam':	'Single-family Detached	',
                    '2FmCon':	'Two-family Conversion; originally built as one-family dwelling',
                    'Duplx':	'Duplex',
                    'TwnhsE':	'Townhouse End Unit',
                    'TwnhsI':	'Townhouse Inside Unit',
                }
            }
        },
        {
            'Label': 'HouseStyle',
            'Data' :  {
                'Description': 'Style of dwelling',
                'Form': {
                    '1Story':	'One story',
                    '1.5Fin':	'One and one-half story: 2nd level finished',
                    '1.5Unf':	'One and one-half story: 2nd level unfinished',
                    '2Story':	'Two story',
                    '2.5Fin':	'Two and one-half story: 2nd level finished',
                    '2.5Unf':	'Two and one-half story: 2nd level unfinished',
                    'SFoyer':	'Split Foyer',
                    'SLvl':	'Split Level',
                }
            }
        },
        {
            'Label': 'OverallQual',
            'Data' :  {
                'Description': 'Rates the overall material and finish of the house',
                'Form': {
                    '10':	'Very Excellent',
                    '9':	'Excellent',
                    '8':	'Very Good',
                    '7':	'Good',
                    '6':	'Above Average',
                    '5':	'Average',
                    '4':	'Below Average',
                    '3':	'Fair',
                    '2':	'Poor',
                    '1':	'Very Poor',
                }
            }
        },
        {
            'Label': 'OverallCond',
            'Data' :  {
                'Description': 'Rates the overall condition of the house',
                'Form': {
                    '10':	'Very Excellent',
                    '9':	'Excellent',
                    '8':	'Very Good',
                    '7':	'Good',
                    '6':	'Above Average',
                    '5':	'Average',
                    '4':	'Below Average',
                    '3':	'Fair',
                    '2':	'Poor',
                    '1':	'Very Poor',
                }
            }
        },
        {
            'Label': 'OverallCond',
            'Data' :  {
                'Description': 'Rates the overall condition of the house',
                'Form': 'int64',
            }
        },
        {
            'Label': 'YearRemodAdd',
            'Data' :  {
                'Description': 'Remodel date (same as construction date if no remodeling or additions)',
                'Form': 'int64',
            }
        },
        {
            'Label': 'RoofStyle',
            'Data' :  {
                'Description': 'Type of roof',
                'Form': {
                    'Flat':	'Flat',
                    'Gable':	'Gable',
                    'Gambrel':	'Gabrel (Barn)',
                    'Hip':	'Hip',
                    'Mansard':	'Mansard',
                    'Shed':	'Shed',
                },
            }
        },
        {
            'Label': 'RoofMatl',
            'Data' :  {
                'Description': 'Roof material',
                'Form': {
                    'ClyTile':	'Clay or Tile',
                    'CompShg':	'Standard (Composite) Shingle',
                    'Membran':	'Membrane',
                    'Metal':	'Metal',
                    'Roll':	'Roll',
                    'Tar&Grv':	'Gravel & Tar',
                    'WdShake':	'Wood Shakes',
                    'WdShngl':	'Wood Shingles',

                }
            }
        },
        {
            'Label': 'Exterior1st',
            'Data' :  {
                'Description': 'Exterior covering on house',
                'Form': {
                    'AsbShng':	'Asbestos Shingles',
                    'AsphShn':	'Asphalt Shingles',
                    'BrkComm':	'Brick Common',
                    'BrkFace':	'Brick Face',
                    'CBlock':	'Cinder Block',
                    'CemntBd':	'Cement Board',
                    'HdBoard':	'Hard Board',
                    'ImStucc':	'Imitation Stucco',
                    'MetalSd':	'Metal Siding',
                    'Other':	'Other',
                    'Plywood':	'Plywood',
                    'PreCast':	'PreCast	',
                    'Stone':	'Stone',
                    'Stucco':	'Stucco',
                    'VinylSd':	'Vinyl Siding',
                    'WdSdng': 'Wood Siding',
                    'WdShing':	'Wood Shingles',
                }
            }
        },
        {
            'Label': 'Exterior2nd',
            'Data' :  {
                'Description': 'Exterior covering on house (if more than one material)',
                'Form': {
                    'AsbShng':	'Asbestos Shingles',
                    'AsphShn':	'Asphalt Shingles',
                    'BrkComm':	'Brick Common',
                    'BrkFace':	'Brick Face',
                    'CBlock':	'Cinder Block',
                    'CemntBd':	'Cement Board',
                    'HdBoard':	'Hard Board',
                    'ImStucc':	'Imitation Stucco',
                    'MetalSd':	'Metal Siding',
                    'Other':	'Other',
                    'Plywood':	'Plywood',
                    'PreCast':	'PreCast	',
                    'Stone':	'Stone',
                    'Stucco':	'Stucco',
                    'VinylSd':	'Vinyl Siding',
                    'WdSdng': 'Wood Siding',
                    'WdShing':	'Wood Shingles',
                }
            }
        },
        {
            'Label': 'MasVnrType',
            'Data' :  {
                'Description': 'Masonry veneer type',
                'Form': {
                    'BrkCmn':	'Brick Common',
                    'BrkFace':	'Brick Face',
                    'CBlock':	'Cinder Block',
                    'None':	'None',
                    'Stone':	'Stone',
                }
            }
        },
        {
            'Label': 'MasVnrArea',
            'Data' :  {
                'Description': 'Masonry veneer area in square feet',
                'Form': 'float64',
            }
        },
        {
            'Label': 'ExterQual',
            'Data' : {
                'Description': 'Evaluates the quality of the material on the exterior',
                'Form': {
                    'Ex':	'Excellent',
                    'Gd':	'Good',
                    'TA':	'Average/Typical',
                    'Fa':	'Fair',
                    'Po':	'Poor',
                }
            }
        },
        {
            'Label': 'ExterCond',
            'Data' : {
                'Description': 'Evaluates the present condition of the material on the exterior',
                'Form': {
                    'Ex':	'Excellent',
                    'Gd':	'Good',
                    'TA':	'Average/Typical',
                    'Fa':	'Fair',
                    'Po':	'Poor',
                }
            }
        },
        {
            'Label': 'Foundation',
            'Data' : {
                'Description': 'Type of foundation',
                'Form': {
                    'BrkTil':	'Brick & Tile',
                    'CBlock':	'Cinder Block',
                    'PConc':	'Poured Contrete	',
                    'Slab':	'Slab',
                    'Stone':	'Stone',
                    'Wood':	'Wood',
                }
            }
        },
        {
            'Label': '1stFlrSF',
            'Data' : {
                'Description': 'First Floor square feet',
                'Form': 'float64',
            }
        },
        {
            'Label': '2ndFlrSF',
            'Data' : {
                'Description': 'Second floor square feet',
                'Form': 'float64',
            }
        },
        {
            'Label': 'LowQualFinSF',
            'Data' : {
                'Description': 'Low quality finished square feet (all floors)',
                'Form': 'float64',
            }
        },
        {
            'Label': 'GrLivArea',
            'Data' : {
                'Description': 'Above grade (ground) living area square feet',
                'Form': 'float64',
            }
        },
    ],
    'Basement': [
        {
            'Label': 'BsmtQual',
            'Data' : {
                'Description': 'Evaluates the height of the basement',
                'Form': {
                    'Ex':	'Excellent (100+ inches)',
                    'Gd':	'Good (90-99 inches)',
                    'TA':	'Typical (80-89 inches)',
                    'Fa':	'Fair (70-79 inches)',
                    'Po':	'Poor (<70 inches',
                    'NA':	'No Basement',
                }
            }
        },
        {
            'Label': 'BsmtCond',
            'Data' : {
                'Description': 'Evaluates the general condition of the basement',
                'Form': {
                    'Ex':	'Excellent',
                    'Gd':	'Good',
                    'TA':	'Typical - slight dampness allowed',
                    'Fa':	'Fair - dampness or some cracking or settling',
                    'Po':	'Poor - Severe cracking, settling, or wetness',
                    'NA':	'No Basement',
                }
            }
        },
        {
            'Label': 'BsmtExposure',
            'Data' : {
                'Description': 'Refers to walkout or garden level walls',
                'Form': {
                    'Gd':	'Good Exposure',
                    'Av':	'Average Exposure (split levels or foyers typically score average or above)	',
                    'Mn':	'Mimimum Exposure',
                    'No':	'No Exposure',
                    'NA':	'No Basement',
                }
            }
        },
        {
            'Label': 'BsmtFinType1',
            'Data' : {
                'Description': 'Rating of basement finished area',
                'Form': {
                    'GLQ':	'Good Living Quarters',
                    'ALQ':	'Average Living Quarters',
                    'BLQ':	'Below Average Living Quarters	',
                    'Rec':	'Average Rec Room',
                    'LwQ':	'Low Quality',
                    'Unf':	'Unfinshed',
                    'NA':	'No Basement',
                }
            }
        },
        {
            'Label': 'BsmtFinSF1',
            'Data' : {
                'Description': 'Type 1 finished square feet',
                'Form': 'float64',
            }
        },
        {
            'Label': 'BsmtFinType2',
            'Data' : {
                'Description': 'Rating of basement finished area (if multiple types)',
                'Form': {
                    'GLQ':	'Good Living Quarters',
                    'ALQ':	'Average Living Quarters',
                    'BLQ':	'Below Average Living Quarters	',
                    'Rec':	'Average Rec Room',
                    'LwQ':	'Low Quality',
                    'Unf':	'Unfinshed',
                    'NA':	'No Basement',
                }
            }
        },
        {
            'Label': 'BsmtFinSF2',
            'Data' : {
                'Description': 'Type 2 finished square feet',
                'Form': 'float64',
            }
        },
        {
            'Label': 'BsmtUnfSF',
            'Data' : {
                'Description': 'Unfinished square feet of basement area',
                'Form': 'float64',
            }
        },
        {
            'Label': 'TotalBsmtSF',
            'Data' : {
                'Description': 'Total square feet of basement area',
                'Form': 'float64',
            }
        },
    ],
    'Utility': [
        {
            'Label': 'Heating',
            'Data' : {
                'Description': 'Type of heating',
                'Form': {
                    'Floor':	'Floor Furnace',
                    'GasA':	'Gas forced warm air furnace',
                    'GasW':	'Gas hot water or steam heat',
                    'Grav':	'Gravity furnace	',
                    'OthW':	'Hot water or steam heat other than gas',
                    'Wall':	'Wall furnace  ',
                },
            }
        },
        {
            'Label': 'HeatingQC',
            'Data' : {
                'Description': 'Heating quality and condition',
                'Form': {
                    'Ex':	'Excellent',
                    'Gd':	'Good',
                    'TA':	'Average/Typical',
                    'Fa':	'Fair',
                    'Po':	'Poor',
                },
            }
        },
        {
            'Label': 'CentralAir',
            'Data' : {
                'Description': 'Central air conditioning',
                'Form': {
                    'N':	'No',
                    'Y':	'Yes',
                },
            }
        },
        {
            'Label': 'Electrical',
            'Data' : {
                'Description': 'Electrical system',
                'Form': {
                    'SBrkr':	'Standard Circuit Breakers & Romex',
                    'FuseA':	'Fuse Box over 60 AMP and all Romex wiring (Average)	',
                    'FuseF':	'60 AMP Fuse Box and mostly Romex wiring (Fair)',
                    'FuseP':	'60 AMP Fuse Box and mostly knob & tube wiring (poor)',
                    'Mix':	'Mixed',
                },
            }
        },
    ],
    'Bathroom': [
        {
            'Label': 'BsmtFullBath',
            'Data' : {
                'Description': 'Basement full bathrooms',
                'Form': 'float64',
            }
        },
        {
            'Label': 'BsmtHalfBath',
            'Data' : {
                'Description': 'Basement half bathrooms',
                'Form': 'float64',
            }
        },
        {
            'Label': 'FullBath',
            'Data' : {
                'Description': 'Full bathrooms above grade',
                'Form': 'float64',
            }
        },
        {
            'Label': 'HalfBath',
            'Data' : {
                'Description': 'Half baths above grade',
                'Form': 'float64',
            }
        },
    ],
    'Bedroom': [
        {
            'Label': 'Bedroom',
            'Data' : {
                'Description': 'Bedrooms above grade (does NOT include basement bedrooms)',
                'Form': 'int64'
            }
        }
    ],
    'Kitchen': [
        {
            'Label': 'Kitchen',
            'Data' : {
                'Description': 'Kitchens above grade',
                'Form': 'int64',
            }
        },
        {
            'Label': 'KitchenQual',
            'Data' : {
                'Description': 'Kitchen quality',
                'Form': {
                    'Ex':	'Excellent',
                    'Gd':	'Good',
                    'TA':	'Typical/Average',
                    'Fa':	'Fair',
                    'Po':	'Poor  ',
                },
            }
        },
    ],
    'Garage': [
        {
            'Label': 'GarageType',
            'Data' : {
                'Description': 'Garage location',
                'Form': {
                    '2Types':	'More than one type of garage',
                    'Attchd':	'Attached to home',
                    'Basment':	'Basement Garage',
                    'BuiltIn':	'Built-In (Garage part of house - typically has room above garage)',
                    'CarPort':	'Car Port',
                    'Detchd':	'Detached from home',
                    'NA':	'No Garage',
                },
            }
        },
        {
            'Label': 'GarageYrBlt',
            'Data' : {
                'Description': 'Year garage was built',
                'Form': 'int64'
            }
        },
        {
            'Label': 'GarageFinish',
            'Data' : {
                'Description': 'Interior finish of the garage',
                'Form': {
                    'Fin':	'Finished',
                    'RFn':	'Rough Finished	',
                    'Unf':	'Unfinished',
                    'NA':	'No Garage',
                }
            }
        },
        {
            'Label': 'GarageCars',
            'Data' : {
                'Description': 'Size of garage in car capacity',
                'Form': 'int64'
            }
        },
        {
            'Label': 'GarageArea',
            'Data' : {
                'Description': 'Size of garage in square feet',
                'Form': 'float64'
            }
        },
        {
            'Label': 'GarageQual',
            'Data' : {
                'Description': 'Garage quality',
                'Form': {
                    'Ex':	'Excellent',
                    'Gd':	'Good',
                    'TA':	'Typical/Average',
                    'Fa':	'Fair',
                    'Po':	'Poor',
                    'NA':	'No Garage',
                }
            }
        },
        {
            'Label': 'GarageCond',
            'Data' : {
                'Description': 'Garage condition',
                'Form': {
                    'Ex':	'Excellent',
                    'Gd':	'Good',
                    'TA':	'Typical/Average',
                    'Fa':	'Fair',
                    'Po':	'Poor',
                    'NA':	'No Garage',
                }
            }
        },
    ],
    'Others': [
        {
            'Label': 'TotRmsAbvGrd',
            'Data' : {
                'Description': 'Total rooms above grade (does not include bathrooms)',
                'Form': 'int64',
            }
        },
        {
            'Label': 'Fireplaces',
            'Data' : {
                'Description': 'Number of fireplaces',
                'Form': 'int64',
            }
        },
        {
            'Label': 'FireplaceQu',
            'Data' : {
                'Description': 'Fireplace quality',
                'Form': {
                    'Ex':	'Excellent - Exceptional Masonry Fireplace',
                    'Gd':	'Good - Masonry Fireplace in main level',
                    'TA':	'Average - Prefabricated Fireplace in main living area or Masonry Fireplace in basement',
                    'Fa':	'Fair - Prefabricated Fireplace in basement',
                    'Po':	'Poor - Ben Franklin Stove',
                    'NA':	'No Fireplace',
                },
            }
        },
        {
            'Label': 'PavedDrive',
            'Data' : {
                'Description': 'Paved driveway',
                'Form': {
                    'Y':	'Paved',
                    'P':	'Partial Pavement',
                    'N':	'Dirt/Gravel',
                }
            }
        },
        {
            'Label': 'WoodDeckSF',
            'Data' : {
                'Description': 'Wood deck area in square feet',
                'Form': 'float64',
            }
        },
        {
            'Label': 'OpenPorchSF',
            'Data' : {
                'Description': 'Open porch area in square feet',
                'Form': 'float64',
            }
        },
        {
            'Label': 'EnclosedPorch',
            'Data' : {
                'Description': 'Enclosed porch area in square feet',
                'Form': 'float64',
            }
        },
        {
            'Label': '3SsnPorch',
            'Data' : {
                'Description': 'Three season porch area in square feet',
                'Form': 'float64',
            }
        },
        {
            'Label': 'ScreenPorch',
            'Data' : {
                'Description': 'Screen porch area in square feet',
                'Form': 'float64',
            }
        },
        {
            'Label': 'PoolArea',
            'Data' : {
                'Description': 'Pool area in square feet',
                'Form': 'float64',
            }
        },
        {
            'Label': 'PoolQC',
            'Data' : {
                'Description': 'Pool quality',
                'Form': {
                    'Ex':	'Excellent',
                    'Gd':	'Good',
                    'TA':	'Average/Typical',
                    'Fa':	'Fair',
                    'NA':	'No Pool',
                },
            }
        },
        {
            'Label': 'Fence',
            'Data' : {
                'Description': 'Fence quality',
                'Form': {
                    'GdPrv':	'Good Privacy',
                    'MnPrv':	'Minimum Privacy',
                    'GdWo':	'Good Wood',
                    'MnWw':	'Minimum Wood/Wire',
                    'NA':	'No Fence',
                },
            }
        },
        {
            'Label': 'MiscFeature',
            'Data' : {
                'Description': 'Miscellaneous feature not covered in other categories',
                'Form': {
                    'Elev':	'Elevator',
                    'Gar2':	'2nd Garage (if not described in garage section)',
                    'Othr':	'Other',
                    'Shed':	'Shed (over 100 SF)',
                    'TenC':	'Tennis Court',
                    'NA':	'None  ',
                },
            }
        },
        {
            'Label': 'MiscVal',
            'Data' : {
                'Description': 'Value of miscellaneous feature',
                'Form': 'float64',
            }
        },
        {
            'Label': 'MoSold',
            'Data' : {
                'Description': 'Month Sold (MM)',
                'Form': 'int64',
            }
        },
        {
            'Label': 'YrSold',
            'Data' : {
                'Description': 'Year Sold (YYYY)',
                'Form': 'int64',
            }
        },
        {
            'Label': 'SaleType',
            'Data' : {
                'Description': 'Type of sale',
                'Form': {
                    'WD': 	'Warranty Deed - Conventional',
                    'CWD':	'Warranty Deed - Cash',
                    'VWD':	'Warranty Deed - VA Loan',
                    'New':	'Home just constructed and sold',
                    'COD':	'Court Officer Deed/Estate',
                    'Con':	'Contract 15% Down payment regular terms',
                    'ConLw':	'Contract Low Down payment and low interest',
                    'ConLI':	'Contract Low Interest',
                    'ConLD':	'Contract Low Down',
                    'Oth':	'Other',
                },
            }
        },
        {
            'Label': 'SaleCondition',
            'Data' : {
                'Description': 'Condition of sale',
                'Form': {
                    'Normal':	'Normal Sale',
                    'Abnorml':	'Abnormal Sale -  trade, foreclosure, short sale',
                    'AdjLand':	'Adjoining Land Purchase',
                    'Alloca':	'Allocation - two linked properties with separate deeds, typically condo with a garage unit	',
                    'Family':	'Sale between family members',
                    'Partial':	'Home was not completed when last assessed (associated with New Homes)',
                },
            }
        },
    ],
}
