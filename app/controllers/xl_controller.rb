class XlController < ApplicationController
	def index
		@planus_choisi = 138 # FN ventilateur
		@projets = Projet.all
		@prix = PrixPoid.joins('LEFT OUTER JOIN t_offre ON t_offre.id = t_prix_poids.id_offre').joins('LEFT OUTER JOIN t_projet ON t_projet.id = t_prix_poids.id_projet').joins('LEFT OUTER JOIN t_items ON t_items.id = t_prix_poids.id_item').joins('LEFT OUTER JOIN t_fournisseur ON t_fournisseur.id = t_offre.id_fournisseur').joins('LEFT OUTER JOIN t_conditions ON t_conditions.id = t_projet.id_conditions').joins('LEFT OUTER JOIN t_folios ON t_folios.id = t_items.id_folios').where(:t_items => {:code_planus => @planus_choisi})
		@conditions = Condition.all
		render :xlsx => "index", :filename => "fn.xlsx"
	end
end
