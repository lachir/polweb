class ItemsController < ApplicationController
	def index
		@items = Item.joins("LEFT OUTER JOIN t_projet ON t_projet.id = t_items.id_projet").joins("LEFT OUTER JOIN t_folios ON t_folios.id = t_items.id_folios").joins("LEFT OUTER JOIN t_codification ON t_codification.planus = t_items.equipement").joins('LEFT OUTER JOIN t_prix_poids  ON t_prix_poids.id_item = t_items.id').joins('LEFT OUTER JOIN t_offre ON t_offre.id = t_prix_poids.id_offre').joins('LEFT OUTER JOIN t_fournisseur ON t_fournisseur.id = t_offre.id_fournisseur')
		@items_grid = initialize_grid(@items,  enable_export_to_csv: true,
  csv_file_name:        'items', name: 'items', csv_field_separator: ';')
		    export_grid_if_requested
	end
end
