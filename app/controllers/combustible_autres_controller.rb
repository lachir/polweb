class CombustibleAutresController < ApplicationController
	def create

		@projet = Projet.find_by_id(params[:projet_id])
		@combustible_autre = @projet.combustible_autre.create(combustible_autre_params)
    redirect_to projet_path(@projet, :anchor => '64')
	end

	def destroy
    @projet = Projet.find(params[:projet_id])
    @combustible_autre = @projet.combustible_autre.find(params[:id])
    @combustible_autre.destroy
    redirect_to projet_path(@projet, :anchor => '64')
 	 end
  def edit
     @projet = Projet.find(params[:projet_id])
     @combustible_autre = @projet.combustible_autre.find(params[:id])
       unless session[:ecriture] 
    
   session[:return_to] =  url_for(@projet)
       redirect_to new_session_path 
  end
  end
    def update
      @combustible_autre = CombustibleAutre.find(params[:id])
    respond_to do |format|
      if @combustible_autre.update(combustible_autre_params)
        format.html { redirect_to projet_path(@combustible_autre.id_projet, :anchor => '64'), notice: 'combustible_autre was successfully updated.' }
        format.json { render :show, status: :ok, location: @combustible_autre }
      else
        format.html { render :edit }
        format.json { render json: @combustible_autre.errors, status: :unprocessable_entity }
      end
    end
  end
	private
	def combustible_autre_params
	params.require(:combustible_autre).permit(:fonction, :combustible_defaut_fr, :combustible_defaut_en, :pci_defaut, :unite_pci, :combustible_autres_volatiles_defaut, :unite_combustible_autres_volatiles, :cendres_defaut, :unite_cendre, :hardgrove_defaut, :teneur_soufre_defaut, :teneur_chlore_defaut, :teneur_azote_defaut, 
:teneur_carbone_defaut, :teneur_hydrogene_defaut, :teneur_oxygene_defaut)
  end
end
