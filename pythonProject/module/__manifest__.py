{

  'name': "Real-Estate Management",  # Author: Ahsan Saeed

  'version': '3.8',  # Author: Ahsan Saeed

  'depends': ['base'],  # Author: Ahsan Saeed

  'author': "Osama Imran",  # Author: Ahsan Saeed

  'category': 'Category',  # Author: Ahsan Saeed

  'description': """  # Author: Ahsan Saeed

  This is a test module of Real-Estate Management!  # Author: Ahsan Saeed

  Written for the Odoo Quickstart Tutorial.  # Author: Ahsan Saeed

  """,  # Author: Ahsan Saeed

  # data files always loaded at installation  # Author: Ahsan Saeed

  'data': [  # Author: Ahsan Saeed



  ],  # Author: Ahsan Saeed

  'installable': True,  # Author: Ahsan Saeed

  'auto_install': False,  # Author: Ahsan Saeed

  'application': False,  # Author: Ahsan Saeed

}  # Author: Ahsan Saeed

   # You need to call/import the datafile in your data key of __manifest__.py file.

<odoo>

   <data>

       <record id="any_unique_id" model="your.model">

           <field name="your_field_name">Field Value</field>

           <field name="your_field_name1">1</field>

           <field name="your_field_name2"></field>

       </record>

   </data>

</odoo>