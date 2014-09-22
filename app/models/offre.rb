class Offre < ActiveRecord::Base
	self.table_name = 't_offre'
	belongs_to :projet, foreign_key: 'id_projet'
	belongs_to :fournisseur, foreign_key: 'id_fournisseur'
		self.primary_key = 'id'
	validates :date_offre, :presence => true, format: { with: /[0-3][0-9]\/[0-1][0-9]\/20[0-3][0-9]/, message: "La date doit être au format JJ/MM/AAAA" }
	has_many :prix_poid, foreign_key: 'id_offre', :dependent => :destroy #si une offre est supprimée, les attributs de poids et de prix sont supprimées également par imbriquation 
	validates :id_fournisseur, :presence => {:message => 'Il faut un fournisseur'}
	accepts_nested_attributes_for :prix_poid, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true #génèer l'imbriquation de prix_poid dans offre, pour générer le formulaire de saisie. Si des champs de prix et de poids sont vide, ils ne sont pas pris en compte pour la sauvegarde dans la base
end