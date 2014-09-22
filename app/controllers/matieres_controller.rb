class MatieresController < ApplicationController
  #il n'y a pas de new, car les matières sont générées par le controlleur projet
	def create

		@projet = Projet.find_by_id(params[:projet_id])
		@matiere = @projet.matiere.create(matiere_params)
		redirect_to projet_path(@projet)
	end
 
	def destroy
    @projet = Projet.find(params[:projet_id])
    @matiere = @projet.matiere.find(params[:id])
    @matiere.destroy
    redirect_to projet_path(@projet)
 	 end
 	  def edit
       @projet = Projet.find(params[:projet_id])
       @matiere = @projet.matiere.find(params[:id])
                       # Vérifie si l'utilisateur possède les droits d'écriture
      unless session[:ecriture] 
    
   session[:return_to] =  url_for(@projet)
       redirect_to new_session_path 
  end
	  end
    def update
      @matiere = Matiere.find(params[:id])
    respond_to do |format|
      if @matiere.update(matiere_params)
        format.html { redirect_to projet_path(session[:id_projet]), notice: 'matiere was successfully updated.' }
        format.json { render :show, status: :ok, location: @matiere }
      else
        format.html { render :edit }
        format.json { render json: @matiere.errors, status: :unprocessable_entity }
      end
    end
  end
  def importer
    if session[:id_projet] == 0 then
      redirect_to projets_path
    else
    @projet = Projet.find_by_id(session[:id_projet])
      @matieres = Matiere.where("id_projet = ?", params["IdInput"])
      @matieres.each do |m|
        @nouvelle_matiere = Matiere.new
        @nouvelle_matiere = m.dup
        @nouvelle_matiere.id_projet = session[:id_projet]
        @nouvelle_matiere.save!
      end
      redirect_to projet_path(session[:id_projet])      
    end
  end
  def import
  @projets = Projet.all
  @projet_qui_recoit = Projet.find_by_id(session[:id_projet])
  end

	private
	def matiere_params
	params.require(:matiere).permit(:matiere_fr, :matiere_en , :densite_convoyee, :densite_stockee , :unite_densite, :granulometrie, :unite_granulometrie, :humidite_min, :humidite_moy, :humidite_max, :temperature, :unite_temperature, :angle_talutage , :position_matiere)	
end
end
