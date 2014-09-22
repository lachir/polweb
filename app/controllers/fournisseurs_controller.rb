class FournisseursController < ApplicationController
  before_action :set_fournisseur, only: [:show, :edit, :update, :destroy]

  # GET /fournisseurs
  # GET /fournisseurs.json
  def index
    @fournisseurs = Fournisseur.all.order(nom: :asc)
    @fournisseurs_grid = initialize_grid(@fournisseurs,csv_field_separator: ';', enable_export_to_csv: true,
  csv_file_name:        'fournisseurs')
        export_grid_if_requested

  end

  # GET /fournisseurs/1
  # GET /fournisseurs/1.json
  def show

    @fournisseur = Fournisseur.find_by_id(params[:id])
    @offres = Offre.joins('LEFT OUTER JOIN t_fournisseur ON t_offre.id_fournisseur = t_fournisseur.id').joins('LEFT OUTER JOIN t_projet ON t_projet.id = t_offre.id_projet')
    @offre = initialize_grid(@offres, :conditions => ['id_fournisseur = ?', @fournisseur.id], csv_field_separator: ';',enable_export_to_csv: true,
  csv_file_name:        'projets_du_fournisseur')
    #render plain: @fournisseur.inspect
    export_grid_if_requested

  end

  # GET /fournisseurs/new
  def new
  
    @fournisseur = Fournisseur.new
        # Vérifie si l'utilisateur possède les droits d'écriture
      unless session[:ecriture] 
    
   session[:return_to] =  url_for(@fournisseur)
       redirect_to new_session_path 
  end  
end

  # GET /fournisseurs/1/edit
  def edit
        # Vérifie si l'utilisateur possède les droits d'écriture
        # Vérifie si l'utilisateur possède les droits d'écriture
      unless session[:ecriture] 
    
   session[:return_to] =  url_for(Fournisseur.find_by_id(params[:id]))
       redirect_to new_session_path 
  end   
   end

  # POST /fournisseurs
  # POST /fournisseurs.json
  def create

    @fournisseur = Fournisseur.new(fournisseur_params)
    
    respond_to do |format|
      if @fournisseur.save
        format.html { redirect_to @fournisseur, notice: 'Fournisseur was successfully created.' }
        format.json { render :show, status: :created, location: @fournisseur }
      else
        format.html { render :new }
        format.json { render json: @fournisseur.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fournisseurs/1
  # PATCH/PUT /fournisseurs/1.json
  def update
    respond_to do |format|
      if @fournisseur.update(fournisseur_params)
        format.html { redirect_to @fournisseur, notice: 'Fournisseur was successfully updated.' }
        format.json { render :show, status: :ok, location: @fournisseur }
      else
        format.html { render :edit }
        format.json { render json: @fournisseur.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fournisseurs/1
  # DELETE /fournisseurs/1.json
  def destroy
    @fournisseur.destroy
    respond_to do |format|
      format.html { redirect_to fournisseurs_url, notice: 'Fournisseur was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fournisseur
      @fournisseur = Fournisseur.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fournisseur_params
      params[:fournisseur].permit(:nom, :id, :pays)
    end
end
