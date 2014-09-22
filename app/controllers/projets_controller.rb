# encoding: UTF-8
class ProjetsController < ApplicationController
		def index
		@projets = Projet.joins("LEFT OUTER JOIN t_client ON t_projet.id_client = t_client.id")
		@projets_grid = initialize_grid(@projets.order(code_complet: :asc),csv_field_separator: ';',:include => [:type_projet, :categorie_projet],  enable_export_to_csv: true,
  csv_file_name:        'projets')
		    export_grid_if_requested

	end
	def show
	 	@projet = Projet.joins("LEFT OUTER JOIN t_client ON t_projet.id_client = t_client.id").joins("LEFT OUTER JOIN t_categorie_projet ON t_categorie_projet.id = t_projet.id_categorieprojet").joins("LEFT OUTER JOIN t_type ON t_type.id = t_projet.id_type").joins("LEFT OUTER JOIN t_conditions ON t_conditions.id = t_projet.id_conditions").joins("LEFT OUTER JOIN t_type_projet ON t_type_projet.id = t_projet.id_typeprojet").joins("LEFT OUTER JOIN t_utilite ON t_utilite.id_projet = t_projet.id").find_by_id(params[:id])
	 	 	 
	 	@matieres_grid = initialize_grid(@projet.matiere, name: 'gm',csv_field_separator: ';', enable_export_to_csv: true, :csv_file_name =>  ('Matière ' + @projet.code_complet))
	 	@solides_grid = initialize_grid(@projet.combustible_solide,csv_field_separator: ';', name: 'gs', enable_export_to_csv: true, :csv_file_name => ('Combustible ' + @projet.code_complet))
	 	@autres_grid = initialize_grid(@projet.combustible_autre,csv_field_separator: ';', name: 'ga', enable_export_to_csv: true, :csv_file_name => ('Combustible ' + @projet.code_complet))
		@gazeux_grid = initialize_grid(@projet.combustible_gazeux,csv_field_separator: ';', name: 'gg', enable_export_to_csv: true, :csv_file_name => ('Combustible ' + @projet.code_complet))
		@liquides_grid = initialize_grid(@projet.combustible_liquide,csv_field_separator: ';', name: 'gl', enable_export_to_csv: true, :csv_file_name => ('Combustible ' + @projet.code_complet))
		@projetcondition = Projet.find_by_id(params[:id]).id_conditions
		@locales_grid = initialize_grid(Condition, :conditions => ['id = ?', @projetcondition], name: 'gc', enable_export_to_csv: true, :csv_file_name => ('Conditions ' + @projet.code_complet))
		@items_grid =  initialize_grid(@projet.item, name: 'gi',csv_field_separator: ';', enable_export_to_csv: true, :csv_file_name => ('Items ' + @projet.code_complet))
		@locales = Condition.where('id = ?', @projetcondition).first
		@utilites_grid = initialize_grid(@projet.utilite, name: 'gu',csv_field_separator: ';', :csv_file_name => ('Utilite du projet ' + @projet.code_complet))
		session[:id_projet] = @projet.id
		session[:return_to] = url_for(@projet)
		    export_grid_if_requested
	end
	def update
		@projet =  Projet.joins("LEFT OUTER JOIN t_client ON t_projet.id_client = t_client.id").joins("LEFT OUTER JOIN t_categorie_projet ON t_categorie_projet.id = t_projet.id_categorieprojet").joins("LEFT OUTER JOIN t_type ON t_type.id = t_projet.id_type").joins("LEFT OUTER JOIN t_conditions ON t_conditions.id = t_projet.id_conditions").joins("LEFT OUTER JOIN t_type_projet ON t_type_projet.id = t_projet.id_typeprojet").find_by_id(params[:id])
		if @projet.update(projet_params)
    redirect_to @projet    
  else
    render 'show'
  end
  end
  def create
  	    
	@categorie_projet = CategorieProjet.new(projet_params)
	@type_projet = TypeProjet.new(projet_params)
	@categorie_projet.save
		respond_to do |format|
			if @categorie_projet.save
				format.html { redirect_to projets_path, notice: {status: 'success', message: 'La catégorie de projet a été créé.' }}
				format.json { render action: 'show', status: :created, location: @projet }
			else
				format.html { render action: 'show',  notice: {status: 'error', message: 'La catégorie de projet n\'a pas été créé.' } }
				format.json { render json: @projet.errors, status: :unprocessable_entity }
			end
		end
		@type_projet.save
		respond_to do |format|
			if @type_projet.save
				format.html { redirect_to projets_path, notice: {status: 'success', message: 'Le type de projet a été créé.' }}
				format.json { render action: 'show', status: :created, location: @projet }
			else
				format.html { render action: 'show', notice: {status: 'error', message: 'Le type de projet n\'a pas été créé.' }}
				format.json { render json: @projet.errors, status: :unprocessable_entity }
			end
		end

  end
  def migration
  	@projet = Projet.find_by_id(session[:id_projet])
  end
  def migrer
  	@chemin_flowsheet = params["chemin_flowsheet"] # récupère le chemin sous le format W:\5-Technique\AP2550_QASSIM NVLLE LIGNE\4-Plans\Flow_Sheet_Chart\P2550- 
  	if (@chemin_flowsheet =~ /^W:\\5-Technique/ ) == 0 then #vérifie que le chemin est licite, non vide, pas fumé des fesses.
 	@projet = Projet.find_by_id(session[:id_projet]) 
 	@projet.chemin = @chemin_flowsheet
 	@projet.save! #enregistre en bang!
 	@offres = Offre.where("id_projet = ?", @projet.id)
 	@debut_chemin = @chemin_flowsheet.gsub(/4-Plans.*/,'') #récupère le début du chemin, qui est suceptible de changer lors de migration
 	@offres.each do |o|
 		unless o.offre[/3-Technique.*/].to_s.empty? # vérifie que le chemin est valide
 		o.offre = @debut_chemin.to_s + o.offre[/3-Technique.*/].to_s #remplace le début du chemin par le bon
 		o.save!
 		end
	 end
 	end
 	redirect_to projet_path(session[:id_projet])
  end
	private
  def projet_params
    params.require(:projet).permit(:id, :id_typeprojet, :debit, :id_categorieprojet)
  end
	def matiere_params
	params.require(:matiere).permit(:matiere_fr, :matiere_en , :densite_convoyee, :densite_stockee , :unite_densite, :granulometrie, :unite_granulometrie, :humidite_min, :humidite_moy, :humidite_max, :temperature, :unite_temperature, :angle_talutage , :position_matiere)	
end

end