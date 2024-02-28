# -*- coding: utf-8 -*-

from odoo import models, fields, api


# =========================[ const vals  ]===================

# ============================================================

# =========================[ Estate Type Property model ]===================
class EstatePropertyType(models.Model):
    # =========================[===model defination===]===================
    _name = 'estate.property.type'
    _description = 'real estate property types'

    # =================================================================
    # =========================[SQL costrains======]===================

    # =================================================================
    # =========================[main field]===================
    # Char fields
    name = fields.Char(string='type', required=True)

    # =================================================================
    # =========================[relashional fields ]===================
    properties_ids = fields.One2many('estate.property', 'property_type_id', string='properties')
    offer_ids = fields.One2many('estate.property.offers', 'property_type_id', string='offers')
    # ================================================================
    # =========================[compute fields ]===================
    offer_count = fields.Integer(compute='_compute_offer_count', string="offer's count",store=True)

    # ================================================================
    # =========================[related fields ]===================
    # ================================================================

    # =========================[computed functions ]===================
    # =======[_compute_offer_count]==========
    @api.depends('offer_ids')
    def _compute_offer_count(self):
        counter = 0
        for record in self.offer_ids:
            counter += 1
        self.offer_count=counter
        return self.offer_count

    # ================================================================
    # =========================[action functions]===================
    # ========[action_do_get_offers ]========
    def action_do_get_offers(self):
        temp_list=[]
        for record in self.offer_ids:
            temp_list.append(record.id)
        action = {
            'name': 'property offers',
            'res_model': 'estate.property.offers',
            'type': 'ir.actions.act_window',
            'domain': [('id', 'in',temp_list)],
            'view_mode': 'tree',
        }
        return action

    # ================================================================
