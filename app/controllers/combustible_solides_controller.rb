class CombustibleSolidesController < ApplicationController
	def create
		@projet = Projet.find_by_id(params[:projet_id])
		@combustible_solide = @projet.combustible_solide.create(combustible_solide_params)
		redirect_to projet_path(@projet, :anchor => '63')
	end
	def destroy
    @projet = Projet.find(params[:projet_id])
    @combustible_solide = @projet.combustible_solide.find(params[:id])
    @combustible_solide.destroy
    redirect_to projet_path(@projet, :anchor => '63')
 	 end
  def edit
     @projet = Projet.find(params[:projet_id])
     @combustible_solide = @projet.combustible_solide.find(params[:id])
                # Vérifie si l'utilisateur possède les droits d'écriture
      unless session[:ecriture] 
    
   session[:return_to] =  url_for(@projet)
       redirect_to new_session_path 
  end
  end
    def update
     @combustible_solide = CombustibleSolide.find(params[:id])

    respond_to do |format|
      if @combustible_solide.update(combustible_solide_params)
        format.html { redirect_to projet_path(@combustible_solide.id_projet, :anchor => '63'), notice: 'combustible_solide was successfully updated.' }
        format.json { render :show, status: :ok, location: @combustible_solide }
      else
        format.html { render :edit }
        format.json { render json: @combustible_solide.errors, status: :unprocessable_entity }
      end
    end
  end
	private
	def combustible_solide_params
	params.require(:combustible_solide).permit(:fonction, :combustible_defaut_fr, :combustible_defaut_en, :pci_defaut, :unite_pci, :combustible_solides_volatiles_defaut, :unite_combustible_solides_volatiles, :cendres_defaut, :unite_cendre, :hardgrove_defaut, :teneur_soufre_defaut, :teneur_chlore_defaut, :teneur_azote_defaut, 
:teneur_carbone_defaut, :teneur_hydrogene_defaut, :teneur_oxygene_defaut)
end end
