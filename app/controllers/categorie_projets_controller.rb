class CategorieProjetsController < ApplicationController
	def new
		@categorie_projet = CategorieProjet.new
		#vérifie si l'utilisateur fait parti du groupe PolFLow_Writers
		        	  unless session[:ecriture] 
    
   session[:return_to] =  url_for(@categorie_projet)
       redirect_to new_session_path 
  end
	end
	def create
		@categorie_projet = CategorieProjet.new(categorie_projet_params)

		@categorie_projet.save
		respond_to do |format|
			if @categorie_projet.save
				format.html { redirect_to projets_path, notice: {status: 'success', message: 'La catégorie de projet a été créé.' }}
				format.json { render action: 'show', status: :created, location: @projet }
			else
				format.html { render action: 'new' }
				format.json { render json: @categorie_projet.errors, status: :unprocessable_entity }
			end
		end
	end
	private
	def categorie_projet_params
		params.require(:categorie_projet).permit(:Description)
	end
end
