class Fournisseur < ActiveRecord::Base
	self.table_name = 't_fournisseur'
		self.primary_key = 'id'
		has_many :offre, foreign_key: 'id_fournisseur'
	validates_uniqueness_of :nom, :case_sensitive => false# vérifie si le fournisseur n'existe pas déja
end
