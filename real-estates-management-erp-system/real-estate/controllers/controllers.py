# -*- coding: utf-8 -*-
# from odoo import http


# class Real-estate(http.Controller):
#     @http.route('/real-estate/real-estate', auth='public')
#     def index(self, **kw):
#         return "Hello, world"

#     @http.route('/real-estate/real-estate/objects', auth='public')
#     def list(self, **kw):
#         return http.request.render('real-estate.listing', {
#             'root': '/real-estate/real-estate',
#             'objects': http.request.env['real-estate.real-estate'].search([]),
#         })

#     @http.route('/real-estate/real-estate/objects/<model("real-estate.real-estate"):obj>', auth='public')
#     def object(self, obj, **kw):
#         return http.request.render('real-estate.object', {
#             'object': obj
#         })
