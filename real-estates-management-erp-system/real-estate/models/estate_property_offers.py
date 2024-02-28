# -*- coding: utf-8 -*-
from datetime import datetime
from dateutil.relativedelta import relativedelta

from odoo.exceptions import UserError
from odoo import models, fields, api,_

# =========================[ const vals  ]===================
state = [
    ('accepted', 'Accepted'),
    ('refused', 'Refused'),
]


# ============================================================
# =========================[ Estate Property Offer model ]===================
class EstatePropertyOffer(models.Model):
    # =========================[ model defination ]===================
    _name = 'estate.property.offers'
    _description = 'real estate property offers'
    _rec_name='name_id'
    # =================================================================
    # =========================[SQL costrains======]===================
    _sql_constraints = [
        ('price', 'CHECK(price > 0.0)',
         'The  price of a property  should be positive .')
    ]

    # =================================================================
    # =========================[main field]===================
    name_id= fields.Char(string='reception',store=True,required=True, copy=False, readonly=True,
                               default=lambda self: _('New'))
    price = fields.Float(string='price', required=True)
    status = fields.Selection(selection=state, string='status', tracking=True, copy=False)
    # =================================================================

    # =========================[relashional fields ]===================
    partner_id = fields.Many2one('res.partner', string='partner')
    property_id = fields.Many2one('estate.property', string='property', required=True, ondelete='cascade')
    # =================================================================

    # =========================[related fields ]===================
    property_type_id = fields.Many2one(related='property_id.property_type_id', string='property type')
    # =================================================================

    # =========================[computed fields ]===================
    date_deadline = fields.Date(compute='_compute_date_deadline', string='date deadline',
                                inverse='_inverse_date_deadline', store=True)
    validity = fields.Integer(string='validity', default=7)

    # =================================================================

    # =========================[computed functions ]===================
    # =======[_compute_date_deadline]==========
    @api.depends('validity')
    def _compute_date_deadline(self):
        for record in self:
            if record.create_date:
                record.date_deadline = record.create_date + relativedelta(days=record.validity)
            else:
                record.date_deadline = datetime.now() + relativedelta(days=record.validity)

    # =======[_inverse_date_deadline]==========
    def _inverse_date_deadline(self):
        for record in self:
            if record.create_date:
                delta = record.date_deadline - record.create_date.date()
                record.validity = delta.days
            else:
                delta = record.date_deadline - datetime.now()
                record.validity = delta.days

    # ================================================================
    # =========================[action functions]===================
    # ========[action_do_accepted ]========
    def action_do_accepted(self):
        self.property_id.is_cancal = False
        if self.property_id.selling_price <= 0:
            self.status = state[0][0]
            self.property_id.selling_price = self.price
            self.property_id.buyer_id = self.partner_id
            self.property_id.state = 'offer_accepted'
        else:
            raise UserError("Can't accepte more than one offer!")

    # ========[action_do_refused ]========
    def action_do_refused(self):
        self.property_id.is_cancal = False

        if self.property_id.selling_price == self.price:
            self.status = state[1][0]
            self.property_id.selling_price = 0
            self.property_id.buyer_id = None
            self.property_id.state = 'offer_received'
        else:
            self.status = state[1][0]
            self.property_id.state = 'offer_received'

    # ================================================================
    # ================[create overrid]===================================
    @api.model
    def create(self, vals):
        if vals.get('name_id', _('New')) == _('New'):
            vals['name_id'] = self.env['ir.sequence'].next_by_code('estate.offer.sequence') or _('New')
        res = super(EstatePropertyOffer, self).create(vals)
        if res.property_id.exists():
            res.property_id.state = 'offer_received'
        return res
    # ================================================================
