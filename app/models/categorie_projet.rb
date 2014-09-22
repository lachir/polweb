class CategorieProjet < ActiveRecord::Base
	self.table_name = 't_categorie_projet'
	has_many :projet, foreign_key: 'id_categorieprojet'
		self.primary_key = 'id'
end
