class CombustibleGazeuxesController < ApplicationController
  #le nom obscur du controlleur est dû aux conventions de nommage de ruby on rails
	def create

		@projet = Projet.find_by_id(params[:projet_id])
		@combustible_gazeux = @projet.combustible_gazeux.create(combustible_gazeux_params)
		redirect_to projet_path(@projet, :anchor => '61')
	end
  def destroy
    @projet = Projet.find(params[:projet_id])
    @combustible_gazeux = @projet.combustible_gazeux.find(params[:id])
    @combustible_gazeux.destroy
    redirect_to projet_path(@projet, :anchor => '61')
  end
  def edit
    @projet = Projet.find_by_id(params[:projet_id])
    @combustible_gazeux = @projet.combustible_gazeux.find(params[:id])
                    # Vérifie si l'utilisateur possède les droits d'écriture
      unless session[:ecriture] 
    
   session[:return_to] =  url_for(@projet)
       redirect_to new_session_path 
  end
  end
  def update
        @combustible_gazeux = CombustibleGazeux.find(params[:id])

    respond_to do |format|
      if @combustible_gazeux.update(combustible_gazeux_params)
        format.html { redirect_to projet_path(@combustible_gazeux.id_projet, :anchor => '61'), notice: 'combustible_gazeux was successfully updated.' }
        format.json { render :show, status: :ok, location: @combustible_gazeux }
      else
        format.html { render :edit }
        format.json { render json: @combustible_gazeux.errors, status: :unprocessable_entity }
      end
    end
  end

    private
    def combustible_gazeux_params
     params.require(:combustible_gazeux).permit(:hydrogene, :azote, :unite_pci, :pci_defaut, :hydrogene, :ethylene, :azote, :densite, :ethane, :propylene, :unite_densite, :pentane, :unite_densite, :ethylene, :combustible_defaut_fr, :oxygene, :unite_pci, :ethane, :methane, :butane, :oxygene, :oxyde_carbone, :combustible_defaut_fr, :anhydride_carbonique, :methane, :combustible_defaut_en, :propylene, :anhydride_carbone, :combustible_defaut_en, :pci_defaut, :fonction, :densite, :pentane, :butane, :oxyde_carbone, :fonction)
   end
 end