class ConditionsController < ApplicationController
	def new
    @condition = Condition.new
    #enregistre dans la session l'id du projet qui est modifié poru sa transmission entre create, new, update et edit

    session[:id_projet_qui_recoit_les_conditions] = params[:id_projet]
            # Vérifie si l'utilisateur possède les droits d'écriture
      unless session[:ecriture] 
    
   session[:return_to] =  url_for(@condition)
       redirect_to new_session_path 
  end
end

def create

  @condition = Condition.new(condition_params)
 if @condition.save
  @projet = Projet.find_by_id(session[:id_projet_qui_recoit_les_conditions])
    @projet.id_conditions = @condition.id
    @projet.save
    redirect_to projet_path(session[:id_projet_qui_recoit_les_conditions])
  else
    render 'new'
  end
end
def update
	 #render plain: params[:condition].inspect
   @condition = Condition.find(params[:id])

   if @condition.update(condition_params)
    redirect_to session[:return_to]
  else
    render 'edit'
  end
end
def edit
  @condition = Condition.find(params[:id])
          # Vérifie si l'utilisateur possède les droits d'écriture
      unless session[:ecriture] 
    
   session[:return_to] =  url_for(@condition)
       redirect_to new_session_path 
  end
end
def import

  session[:id_projet_qui_recoit_les_conditions] = params[:id_projet]
  @projet_qui_recoit = Projet.find_by_id(session[:id_projet_qui_recoit_les_conditions])
  #Cherche les projets qui ont bien des conditions définies
  @projet_eligible = Projet.all.where('id_conditions != ?', '')
end
def importer 
  # Cherche les conditions du projet à copier via l'id spécifié dans le formulaire précédent
  @projet = Projet.find_by_id(params["IdInput"])
  @condition_importe = Condition.find_by_id(@projet.id_conditions)  
  @condition = Condition.new
  #duplique les conditions importées
  @condition = @condition_importe.dup
  @condition.save!
  #attribue au projet cible les conditions dupliquées
  @projet2 = Projet.find_by_id(session[:id_projet_qui_recoit_les_conditions])
  @projet2.id_conditions = @condition.id
  @projet2.save

  redirect_to projet_path(session[:id_projet_qui_recoit_les_conditions])
end
def destroy

  @condition = Condition.find(params[:id])
    @projet_id = Projet.where(:id_conditions => @condition.id).take.id
 @condition.destroy
 redirect_to projet_path(@projet_id)
end
private
def condition_params
	params.require(:condition).permit(:pays, :id_projet, :id, :site, :altitude, :latitude, :longitude, :temperature_max, :temperature_min, :temperature_max_equip, :temperature_min_equip, :humidite_max, :humidite_min, :precipitation)	
end

end
