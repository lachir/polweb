class UtilitesController < ApplicationController
  before_action :set_utilite, only: [:show, :edit, :update, :destroy]

  # GET /utilites
  # GET /utilites.json
  def index
    @utilites = Utilite.all
  end

  # GET /utilites/1
  # GET /utilites/1.json
  #il n'y a pas de new, car les matières sont générées par le controlleur projet
  # GET /utilites/1/edit
  def edit
        unless session[:ecriture] 
    
   session[:return_to] =  url_for(@projet)
       redirect_to new_session_path 
     end
  end

  # POST /utilites
  # POST /utilites.json
  def create
    @utilite = Utilite.new(utilite_params)
    @projet = Projet.find_by_id(params[:projet_id])
    @utilite = @projet.utilite.create(utilite_params)
    redirect_to projet_path(@projet)
      end

  # PATCH/PUT /utilites/1
  # PATCH/PUT /utilites/1.json
  def update
    respond_to do |format|
      if @utilite.update(utilite_params)
        format.html { redirect_to projet_path(session[:id_projet]), notice: 'Utilite was successfully updated.' }
        format.json { render :show, status: :ok, location: @utilite }
      else
        format.html { render :edit }
        format.json { render json: @utilite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /utilites/1
  # DELETE /utilites/1.json
  def destroy
    @utilite.destroy
    respond_to do |format|
      format.html { redirect_to projet_path(session[:id_projet]), notice: 'Utilite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def importer
    if session[:id_projet] == 0 then
      redirect_to projets_path
    else
    @projet = Projet.find_by_id(session[:id_projet])
      @utilites = Utilite.where("id_projet = ?", params["IdInput"])
      @utilites.each do |u|
        @nouvelle_utilite = Utilite.new
        @nouvelle_utilite = u.dup #Duplique l'utilié du projet source
        @nouvelle_utilite.id_projet = session[:id_projet] # Change l'id du projet vers l'id du projet cible
        @nouvelle_utilite.save! #enregistre 
      end
      redirect_to projet_path(session[:id_projet])      
    end
  end
  def import
  @utilites = Utilite.all
  eligible = []
  @utilites.each do |u|
    eligible << u.id_projet
  end
  @projets = Projet.where(id: eligible)
  @projet_qui_recoit = Projet.find_by_id(session[:id_projet])
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_utilite
      @utilite = Utilite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def utilite_params
      params.require(:utilite).permit(:id_projet, :temp_eau_refroid, :unite_temp_eau, :pression_eau_refroid, :unite_pression_eau, :qualite_ph, :qualite_suspension, :unite_solide_susp, :qualite_granul, :unite_granul, :qualite_solide_dis, :unite_solide_dis, :qualite_durete, :unite_durete, :qualite_fer, :unite_fer, :qualite_manganese, :unite_manganese, :air_pression, :unite_pression, :air_granul_poussiere, :unite_granul_poussiere, :classe_norme)
    end
end
