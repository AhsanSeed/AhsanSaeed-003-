# -*- coding: utf-8 -*-

from odoo import models, fields, api

# =========================[ const vals  ]===================

# ============================================================
# =========================[ Estate Property model ]===================
class ResUsers(models.Model):
    # =========================[ model defination ]===================
    _inherit='res.users'
    # =================================================================
    # =========================[SQL costrains======]===================
    # =================================================================
    # =========================[main field]===================
    # =================================================================
    # =========================[relashional fields ]===================
    property_ids=fields.One2many('estate.property','sales_person_id',string='properties')
    # ================================================================
    # =========================[computed fields ]===================
    # =================================================================


    # =========================[computed functions ]===================
    # ================================================================
    # =========================[action functions]===================
    # ================================================================
    # =========================[Python costrains]===================
    # =================================================================