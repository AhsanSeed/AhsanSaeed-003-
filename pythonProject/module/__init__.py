from import models
from odoo import fields, models


Class EstateProperties(models.Model):

	_name = "estate.property"

	_description = "Model for Real-Estate Properties"


	name = fields.Char()