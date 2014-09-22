class Folio < ActiveRecord::Base
	self.table_name = 't_folios'
	self.primary_key = 'id'
	has_many :item, foreign_key: 'id_folios'
end
