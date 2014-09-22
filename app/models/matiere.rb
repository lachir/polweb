class Matiere < ActiveRecord::Base
	self.table_name = 't_matieres'
	belongs_to :projet, foreign_key: 'id_projet'
		self.primary_key = 'id'
end
