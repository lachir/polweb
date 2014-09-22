class PrixPoidsController < ApplicationController
	def index
		@prix = PrixPoid.joins('LEFT OUTER JOIN t_offre ON t_offre.id = t_prix_poids.id_offre').joins('LEFT OUTER JOIN t_projet ON t_projet.id = t_prix_poids.id_projet').joins('LEFT OUTER JOIN t_items ON t_items.id = t_prix_poids.id_item').joins('LEFT OUTER JOIN t_fournisseur ON t_fournisseur.id = t_offre.id_fournisseur').joins('LEFT OUTER JOIN t_folios ON t_folios.id = t_items.id_folios').joins('LEFT OUTER JOIN t_projet ON t_projet.id = t_prix_poids.id_projet')
		@prixdeux = PrixPoid.joins('LEFT OUTER JOIN t_fournisseur ON t_fournisseur.id = t_offre.id_fournisseur').joins('LEFT OUTER JOIN t_folios ON t_folios.id = t_items.id_folios')
		@prix_grid = initialize_grid(@prix, enable_export_to_csv: true, :csv_file_name => 'consultation', csv_field_separator: ';', name: 'consultation')
    export_grid_if_requested
	end
	def texte
		@prix = PrixPoid.joins('LEFT OUTER JOIN t_offre ON t_offre.id = t_prix_poids.id_offre').joins('LEFT OUTER JOIN t_projet ON t_projet.id = t_prix_poids.id_projet').joins('LEFT OUTER JOIN t_items ON t_items.id = t_prix_poids.id_item').joins('LEFT OUTER JOIN t_fournisseur ON t_fournisseur.id = t_offre.id_fournisseur').joins('LEFT OUTER JOIN t_folios ON t_folios.id = t_items.id_folios')
		@prixdeux = PrixPoid.joins('LEFT OUTER JOIN t_fournisseur ON t_fournisseur.id = t_offre.id_fournisseur').joins('LEFT OUTER JOIN t_folios ON t_folios.id = t_items.id_folios')
		@prix_grid = initialize_grid(@prix, enable_export_to_csv: true, :csv_file_name => 'consultation', csv_field_separator: ';', name: 'consultation')
    export_grid_if_requested
	end
		def remarque
		@prix = PrixPoid.joins('LEFT OUTER JOIN t_offre ON t_offre.id = t_prix_poids.id_offre').joins('LEFT OUTER JOIN t_projet ON t_projet.id = t_prix_poids.id_projet').joins('LEFT OUTER JOIN t_items ON t_items.id = t_prix_poids.id_item').joins('LEFT OUTER JOIN t_fournisseur ON t_fournisseur.id = t_offre.id_fournisseur').joins('LEFT OUTER JOIN t_folios ON t_folios.id = t_items.id_folios')
		@prixdeux = PrixPoid.joins('LEFT OUTER JOIN t_fournisseur ON t_fournisseur.id = t_offre.id_fournisseur').joins('LEFT OUTER JOIN t_folios ON t_folios.id = t_items.id_folios')
		@prix_grid = initialize_grid(@prix, enable_export_to_csv: true, :csv_file_name => 'consultation', csv_field_separator: ';', name: 'consultation')
    export_grid_if_requested
	end
end
