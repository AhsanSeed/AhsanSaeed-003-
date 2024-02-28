# -*- coding: utf-8 -*-
{
    'name': "real-estate",

    'description': "real estate management system",

    'author': "Ahsan Saeed",
    'website': "https://github.com/AhsanSeed/AhsanSaeed-003-",

    'sequence': -100,

    'category': 'Uncategorized',
    'version': '0.1',
    'application': 'Ture',
    # any module necessary for this one to work correctly
    'depends': ['base'],

    # always loaded
    'data': [
        'security/ir.model.access.csv',

        'data/data.xml',

        'views/estate_propirty_offers.xml',
        'views/estate_propirty_tags.xml',
        'views/estate_propirty_type.xml',
        'views/estate_propirty.xml',
        'views/menu.xml',



    ],
    # only loaded in demonstration mode
    'demo': [
        'demo/demo.xml',
    ],
}
