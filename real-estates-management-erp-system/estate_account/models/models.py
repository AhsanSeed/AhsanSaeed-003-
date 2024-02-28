# -*- coding: utf-8 -*-

from odoo import models, fields, api

class EstateProperty(models.Model):

    # ---------------------------------------- Private Attributes ---------------------------------

    _inherit = "estate.property"

    # ---------------------------------------- Action Methods -------------------------------------

    def action_do_sold(self):
        res = super().action_do_sold()
        journal = self.env["account.journal"].search([("type", "=", "sale")], limit=1)
        # Another way to get the journal:
        # journal = self.env["account.move"].with_context(default_move_type="out_invoice")._get_default_journal()
        for record in self:
            # self.active=2
            self.env["account.move"].create(
                {
                    "partner_id": record.buyer_id.id,
                    "move_type": "out_invoice",
                    "journal_id": journal.id,
                    "invoice_line_ids": [
                        (
                            0,
                            0,
                            {
                                "name": record.name,
                                "quantity": 1.0,
                                "price_unit": record.selling_price,
                            },
                        ),
                        (
                            0,
                            0,
                            {
                                "name": "Administrative fees",
                                "quantity": 1.0,
                                "price_unit": record.selling_price * 0.06,
                            },
                        ),
                    ],
                }
            )
        return