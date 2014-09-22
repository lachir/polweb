class TypeProjetsController < ApplicationController
		def new
		@type_projet = TypeProjet.new
		        # Vérifie si l'utilisateur possède les droits d'écriture
      unless session[:ecriture] 
    
   session[:return_to] =  url_for(@type_projet)
       redirect_to new_session_path 
  end  
	end
	def create
		@type_projet = TypeProjet.new()

		@type_projet.save
		respond_to do |format|
			if @type_projet.save
				format.html { redirect_to projets_path, notice: {status: 'success', message: 'La catégorie de projet a été créé.' }}
				format.json { render action: 'show', status: :created, location: @projet }
			else
				format.html { render action: 'new' }
				format.json { render json: @type_projet.errors, status: :unprocessable_entity }
			end
		end
	end
	    # Never trust parameters from the scary internet, only allow the white list through.
    def type_projet_params
      params.require(:type_projet).permit(:Description)
    end
end
