class RechercheController < ApplicationController
	def recherche_g
		@ggrid = initialize_grid(CombustibleGazeux.all, order:           't_projet.code_complet',
  order_direction: 'asc', joins: :projet,csv_field_separator: ';',  enable_export_to_csv: true, csv_file_name: 'Combustibles Gazeux')
	end
	def recherche_l
				@lgrid = initialize_grid(CombustibleLiquide.all, order:           't_projet.code_complet',
  order_direction: 'asc', joins: :projet,csv_field_separator: ';',  enable_export_to_csv: true, csv_file_name: 'Combustibles liquides')

	end
	def recherche_s
					@sgrid = initialize_grid(CombustibleSolide.all, order:           't_projet.code_complet',
  order_direction: 'asc', joins: :projet,csv_field_separator: ';',  enable_export_to_csv: true, csv_file_name: 'Combustibles liquides')
	
	end
	def recherche_a
						@agrid = initialize_grid(CombustibleAutre.all, order:           't_projet.code_complet',
  order_direction: 'asc', joins: :projet,csv_field_separator: ';',  enable_export_to_csv: true, csv_file_name: 'Combustibles liquides')

	end
	def recherche_u
						@ugrid = initialize_grid(Utilite.all, order:           't_projet.code_complet',
  order_direction: 'asc', joins: :projet,csv_field_separator: ';',  enable_export_to_csv: true, csv_file_name: 'Combustibles liquides')

	end
	def recherche_m
						@mgrid = initialize_grid(Matiere.all, order:           't_projet.code_complet',
  order_direction: 'asc', joins: :projet,csv_field_separator: ';',  enable_export_to_csv: true, csv_file_name: 'Combustibles liquides')

	end
	def recherche_c
						@cgrid = initialize_grid(Condition.all, order:           't_projet.code_complet',
  order_direction: 'asc', joins: :projet,csv_field_separator: ';',  enable_export_to_csv: true, csv_file_name: 'Combustibles liquides')

	end

end
