# -*- coding: utf-8 -*-
from odoo import models, fields, api
# =========================[ const vals  ]===================

# =============================================================
# =========================[ Estate Property Offer model ]===================
class EstatePropertyTags(models.Model):
    # =========================[ model defination ]===================
    _name = 'estate.property.tags'
    _description = 'real estate property tags'
    # =================================================================
    # =========================[SQL costrains======]===================
    _sql_constraints = [
        ('tag_name_uniq', 'unique(name)','The tag name must be unique .')
    ]
    # =================================================================
    # =========================[main field]===================
    name = fields.Char(string='tag name',required=True)
    color = fields.Integer(string='color',required=True,default=3)
    # =================================================================











