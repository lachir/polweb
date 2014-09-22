class PrixPoid < ActiveRecord::Base
	#le s est retiré à cause des conventions de nommage de Ruby on Rails
	self.table_name = 't_prix_poids'
	self.primary_key = 'id'
	belongs_to :offre, foreign_key: 'id_offre'
	belongs_to :projet, foreign_key: 'id_projet'
	belongs_to :item, foreign_key: 'id_item'
end
