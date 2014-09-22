class Item < ActiveRecord::Base
	self.table_name = 't_items'
	belongs_to :projet, foreign_key: 'id_projet'
	belongs_to :folio , foreign_key: 'id_folios'
		self.primary_key = 'id'
	has_many :prix_poid, foreign_key: 'id_item'
end
