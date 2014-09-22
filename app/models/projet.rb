class Projet < ActiveRecord::Base
	self.table_name = 't_projet'
	self.primary_key = 'id'
	has_many :matiere, foreign_key: 'id_projet'
	has_many :folio, foreign_key: 'id_projet'
	has_many :item, foreign_key: 'id_projet'
	has_many :prix_poids, foreign_key: 'id_projet'
	has_many :combustible_liquide, foreign_key: 'id_projet'
	has_many :combustible_solide, foreign_key: 'id_projet'
	has_many :combustible_gazeux, foreign_key: 'id_projet'
	has_many :combustible_autre, foreign_key: 'id_projet'
	has_many :offre, foreign_key: 'id_projet', :dependent => :destroy
	has_one :utilite, foreign_key: 'id_projet'
	has_many :option, foreign_key: 'id_projet'
	has_many :prix_poid, foreign_key: 'id_projet'
	has_many :utilite, foreign_key: 'id_projet'

	belongs_to :categorie_projet, foreign_key: 'id_categorieprojet'
	belongs_to :type, foreign_key: 'id_type'
	belongs_to :type_projet, foreign_key: 'id_typeprojet'
	belongs_to :client, foreign_key: 'id_client'
	belongs_to :condition, foreign_key: 'id_conditions'
	accepts_nested_attributes_for :offre, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true  #génère l'imbriquation de offre dans projet, pour générer le formulaire de saisie. Si des champs de prix et de poids sont vide, ils ne sont pas pris en compte pour la sauvegarde dans la base
	accepts_nested_attributes_for :combustible_liquide
	accepts_nested_attributes_for :combustible_solide
	accepts_nested_attributes_for :combustible_gazeux
	accepts_nested_attributes_for :combustible_autre
	accepts_nested_attributes_for :matiere
def self.search(query)
  where("code_complet like ?", "%#{query}%") 
end
end
