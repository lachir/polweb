class TypeProjet < ActiveRecord::Base
	self.table_name = 't_type_projet'
	belongs_to :projet, foreign_key: 'id_typeprojet'
		self.primary_key = 'id'
end
