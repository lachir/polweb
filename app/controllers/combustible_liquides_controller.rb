class CombustibleLiquidesController < ApplicationController
	def create
		@projet = Projet.find_by_id(params[:projet_id])
		@combustible_liquide = @projet.combustible_liquide.create(combustible_liquide_params)
		redirect_to projet_path(@projet, :anchor => '62')
	end
	def destroy
    @projet = Projet.find(params[:projet_id])
    @combustible_liquide = @projet.combustible_liquide.find(params[:id])
    @combustible_liquide.destroy
    redirect_to projet_path(@projet, :anchor => '62')
 	 end
 	   def edit
       @projet = Projet.find(params[:projet_id])
       @combustible_liquide = @projet.combustible_liquide.find(params[:id])
                       # Vérifie si l'utilisateur possède les droits d'écriture
      unless session[:ecriture] 
    
   session[:return_to] =  url_for(@projet)
       redirect_to new_session_path 
  end
  end
    def update
             @combustible_liquide = CombustibleLiquide.find(params[:id])

    respond_to do |format|
      if @combustible_liquide.update(combustible_liquide_params)
        format.html { redirect_to projet_path(@combustible_liquide.id_projet, :anchor => '62'), notice: 'combustible_liquide was successfully updated.' }
        format.json { render :show, status: :ok, location: @combustible_liquide }
      else
        format.html { render :edit }
        format.json { render json: @combustible_liquide.errors, status: :unprocessable_entity }
      end
    end
  end

	private
	def combustible_liquide_params
	params.require(:combustible_liquide).permit(:fonction, :combustible_defaut_fr, :combustible_defaut_en, :pci_defaut, :unite_pci, :combustible_liquides_volatiles_defaut, :unite_combustible_liquides_volatiles, :cendres_defaut, :unite_cendre, :hardgrove_defaut, :teneur_soufre_defaut, :teneur_chlore_defaut, :teneur_azote_defaut, 
:teneur_carbone_defaut, :teneur_hydrogene_defaut, :teneur_oxygene_defaut)
end
end