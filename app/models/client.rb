class Client < ActiveRecord::Base
	self.table_name = 't_client'
	has_many :projet, foreign_key: 'id_client'
	validates_uniqueness_of :nom, :case_sensitive => false # vérifie si le fournisseur n'existe pas déja
	self.primary_key = 'id'
end
