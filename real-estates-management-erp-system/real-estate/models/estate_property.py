# -*- coding: utf-8 -*-
from datetime import datetime
from dateutil.relativedelta import relativedelta

from odoo.exceptions import UserError, ValidationError
from odoo import models, fields, api

# =========================[ const vals  ]===================
garden_orientation = [
    ('north', 'North'),
    ('south', 'South'),
    ('east', 'East'),
    ('west', 'West'),
]
# =================================================
state = [
    ('new', 'New'),
    ('offer_received', 'Offer Received'),
    ('offer_accepted', 'Offer Accepted'),
    ('accepted', 'Sold'),
    ('canceled', 'Canceled'),
]


# ============================================================
# =========================[ Estate Property model ]===================
class EstateProperty(models.Model):
    # =========================[ model defination ]===================
    _name = 'estate.property'
    _description = 'real estate property'
    # =================================================================
    # =========================[SQL costrains======]===================
    _sql_constraints = [
        ('expected_price', 'CHECK(expected_price >= 0.0)',
         'The expected price of a property  should be positive .')
    ]

    _sql_constraints = [
        ('selling_price', 'CHECK(selling_price >= 0.0)',
         'The selling price of a property  should be positive .')
    ]

    # =================================================================
    # =========================[main field]===================
    # Char fields
    name = fields.Char(string='title', required=True)
    postcode = fields.Char(string='postcode')
    # Text fields
    description = fields.Text(string='description')
    # Date fields
    date_availability = fields.Date(string='available from',
                                    default=lambda self: datetime.now() + relativedelta(months=3), copy=False)
    # Float fields
    expected_price = fields.Float(string='expected price')
    selling_price = fields.Float(string='selling price', readonly=True, copy=False)
    # Integer fields
    bedrooms = fields.Integer(string='bedrooms', default=2)
    living_area = fields.Integer(string='living area(sqm)')
    facades = fields.Integer(string='facades')
    garden_area = fields.Integer(string='garden area(sqm)')
    garage = fields.Boolean(string='garage')
    garden = fields.Boolean(string='garden')
    is_cancal = fields.Boolean(string='active',default=False)
    is_sold = fields.Boolean(string='active',default=False)
    active = fields.Boolean(string='active',default=True)
    # Selection fields
    garden_orientation = fields.Selection(selection=garden_orientation, string='garden_orientation')
    state = fields.Selection(selection=state, string='status', tracking=True, default=state[0][0])
    # =================================================================
    # =========================[relashional fields ]===================
    property_type_id = fields.Many2one('estate.property.type', string='type')
    buyer_id = fields.Many2one('res.partner', string='buyer')
    sales_person_id = fields.Many2one('res.users', string='salesperson', tracking=True,
                                      default=lambda self: self.env.user)
    tag_ids = fields.Many2many('estate.property.tags', string='property tags', tracking=True)
    offer_ids = fields.One2many('estate.property.offers', 'property_id', ondelete='cascade', string='property offers',
                                tracking=True)
    # ================================================================
    # =========================[computed fields ]===================
    total_area = fields.Integer(compute='_compute_total_area', string='total area(msq)')
    best_price = fields.Float(compute='_compute_best_price', string='best offer')

    # =================================================================
    # =========================[computed functions ]===================
    # ========[_compute_total_area]========
    @api.depends('garden_area', 'living_area')
    def _compute_total_area(self):
        self.total_area = self.garden_area + self.living_area

    # =======[_compute_best_price]==========
    @api.depends('offer_ids')
    def _compute_best_price(self):
        price = []
        if self.offer_ids:
            for record in self.offer_ids:
                for obj in record:
                    price.append(obj.price)
                self.best_price = max(price)

        else:
            self.best_price = 0

    # ================================================================
    # ================# =========================[ model defination ]============================[onchange functions ]===================
    # ========[_onchange_garden_area ]========
    @api.onchange("garden_area")
    def _onchange_garden_area(self):
        if self.garden_area:
            self.garden_orientation = garden_orientation[0][0]
        else:
            self.garden_orientation = None

    # ================================================================
    # =========================[action functions]===================
    # ========[action_do_cancal ]========
    def action_do_cancal(self):
        self.state = state[4][0]
        self.selling_price = 0.0
        self.buyer_id = None
        self.is_cancal=True
        self.is_sold=False
        for rec in self.offer_ids:
            rec.status = 'refused'

    # ========[action_do_sold ]========
    def action_do_sold(self):
        if self.state != state[4][0]:

            if self.state =='offer_accepted' :
                self.state = state[3][0]

            else:
                maxprice = {}
                for rec in self.offer_ids:
                    maxprice[rec.partner_id] = rec.price
                    if rec.price==self.best_price:
                        rec.status='accepted'

                self.selling_price = self.best_price

                for key, value in maxprice.items():
                    if self.selling_price == value:
                        self.buyer_id = key
                self.state = state[3][0]
                self.is_sold=True
                self.is_cancal=False
        else:
            raise UserError("Can't sold an cancal property!")

    # ================================================================
    # =========================[Python costrains======]===================
    @api.constrains('selling_price')
    def _check_selling_price(self):
        for record in self:
            if record.selling_price < (
                    record.expected_price - (0.1 * record.expected_price)) and record.selling_price != 0.0:
                raise ValidationError("The selling price cannot be less than 90% from ex price")
    # =================================================================
