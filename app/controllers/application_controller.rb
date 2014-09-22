class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :lister_les_projets_depuis_le_cache
  autocomplete :projets, :id, :full => true, :display_value => :code_complet
  rescue_from TinyTds::Error, with: :data_base_error
  rescue_from ActiveRecord::ConnectionTimeoutError , with: :data_base_error
  #initialise le sélecteur de projets, pour émuler le comportement de polflow 2
  #liste les projets depuis le cache pour générer la barre de recherche des projets
  def lister_les_projets_depuis_le_cache
     session[:id_projet] ||= 0
  	@recherche = Rails.cache.fetch("recherche", expires_in: 1.minutes) do
  		projets = Projet.all
  		data = {}
  		i = 0
  			projets.each do |p|
  				data[i] = {}
  				data[i][:label] = p.code_complet+' '+p.nom_code
  		  		data[i][:url] = p.id
            if p.date_creation.length == 8 then 
  		  		data[i][:date] = Date.strptime(p.date_creation.insert(-3,'20'), '%d/%m/%Y')
           elsif p.date_creation.length == 10 then 
            data[i][:date] = Date.strptime(p.date_creation, '%d/%m/%Y')
            end
  		  	i += 1
  			end
  		data
  	end
    @tableau = []
     @recherche.each do |r|
     # @tableau.push({:value => r[1][:label].force_encoding("UTF-8") ,  :url => r[1][:url].to_s})
      @tableau.push({:label => r[1][:label].force_encoding("UTF-8"), :value => r[1][:url].to_s})
    end
    @tabl = @tableau.to_json
  end
  def eager_load_session
    session[:ecriture] = false
    session[:id_projet_qui_recoit_les_conditions] = 144
    session[:editeur] = ''

  end
  def recherche_projet
  	@rechproj = Projet.search(params[:search]).take
  	redirect_to projets_path(@rechproj)
  end
  protected
  def data_base_error
    render plain: "Erreur avec la base de données"
  end
end