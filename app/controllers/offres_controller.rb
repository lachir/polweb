class OffresController < ApplicationController
  def index
    @offre = Offre.joins("LEFT OUTER JOIN t_fournisseur ON t_fournisseur.id = t_offre.id_fournisseur").joins("LEFT OUTER JOIN t_projet ON t_projet.id = t_offre.id_projet")
    @offres_grid = initialize_grid(Offre, :include => [:projet, :fournisseur], custom_order: {'offres.date_offre' => 'CONVERT(date, date_offre, 103'},enable_export_to_csv: true,  csv_file_name: 'offre', csv_field_separator: ';', name: 'offre')
    export_grid_if_requested #convertie les dates qui sont des strings en date format 103 ie jj/mm/aaaa pour leur tri
  end

  def show
    @offre = Offre.joins("LEFT OUTER JOIN t_fournisseur ON t_fournisseur.id = t_offre.id_fournisseur").joins("LEFT OUTER JOIN t_projet ON t_projet.id = t_offre.id_projet").joins("LEFT OUTER JOIN t_prix_poids ON t_prix_poids.id_offre = t_offre.id").find_by_id(params[:id])
    @offres = Offre.all
    @prix = initialize_grid(@offre.prix_poid, include: :item,  enable_export_to_csv: true,  csv_file_name: 'offre_item', csv_field_separator: ';', name: 'offre_item')
    export_grid_if_requested
    #rescue => e
    #redirect_to root_path

  end
  def create
    @offre = Offre.new(offre_params)
    #avant d'insérer le créateur du projet, vérifie qu'il existe
    unless session[:editeur] == '' || session[:editeur] == nil
      #si le créateur se trombe et doit reposter le formulaire, le créateur n'est pas ajouté deux fois
      unless @offre.commentaire.include? 'Offre créee par'
        @offre.commentaire.insert(-1, ' Offre créee par ' + session[:editeur])
      end
    end
    #récupère le fichier d'offre uploadé
    uploaded_io = params[:offre][:offre]
    Dir.mkdir(Rails.root.join('public', 'consult', session[:id_projet].to_s)) unless File.exists?(Rails.root.join('public', 'consult', session[:id_projet].to_s))
    unless uploaded_io == nil    #Vérifie qu'il existe 
      File.open(Rails.root.join('public', 'consult', session[:id_projet].to_s,  uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      @offre.offre =   uploaded_io.original_filename #enregistre le nom du fichier pour sa lecture par l'humain et son download
    end
   # fournie  à l'offre l'id du projet en cours, session[:id_projet] est une variable globale qui s'actualise à chaque visite d'un projet ou qui est demandé si vide.
    if session[:id_projet] == nil then redirect_to root_path end
    @offre.id_projet = session[:id_projet]
    @offre.save
    offre_params[:prix_poid_attributes].each do |p|
      pp = PrixPoid.new(p[1].except(:_destroy))
      pp.id_offre = @offre.id
      if pp.remarque == nil then
        pp.remarque = " 1: #{Item.find_by_id(p[1][:id_item]).description1} 2: #{Item.find_by_id(p[1][:id_item]).description2} 3: #{Item.find_by_id(p[1][:id_item]).description3}"
      else
        pp.remarque = pp.remarque + " 1: #{Item.find_by_id(p[1][:id_item]).description1} 2: #{Item.find_by_id(p[1][:id_item]).description2} 3: #{Item.find_by_id(p[1][:id_item]).description3}"
      end
      pp.save
    end
    respond_to do |format|
     if @offre.save
       format.html { redirect_to offres_path, notice: {status: 'success', message: 'L\'offre a été créé.' }}
       format.json { render action: 'show', status: :created, location: @offre }
     else
       format.html { render action: 'new' }
       format.json { render json: @offre.errors, status: :unprocessable_entity }
     end
   end
 end
 def destroy
  @offre = Offre.find(params[:id])
  @offre.destroy
  # Vérifie que l'utilisateur a les droits d'écriture
        unless session[:ecriture] then redirect_to new_session_path end
  redirect_to offres_path
end
def new
  
  @offre = Offre.new
   if session[:id_projet] == 0 || session[:id_projet] == nil then 
  #vérifie qu'un projet a été séléctionné, implicitement par navigation sur sa page ou par sélection explicite, sinon force le choix du projet
  redirect_to choix_du_projet_path
  else
    @liste_item = Item.find_by_sql("SELECT * FROM t_items WHERE id_projet = #{session[:id_projet]} ORDER BY designation ASC") # sélectionne les items du projets
  end
          # Vérifie si l'utilisateur possède les droits d'écriture
      unless session[:ecriture] 
    
   session[:return_to] =  url_for(@offre)
       redirect_to new_session_path 
  end  
end

def edit

  @offre = Offre.find_by_id(params[:id])
  
    session[:id_projet] = @offre.id_projet
  
  @liste_item = Item.find_by_sql("SELECT * FROM t_items WHERE id_projet = #{session[:id_projet]} ORDER BY designation ASC")
          # Vérifie si l'utilisateur possède les droits d'écriture
      unless session[:ecriture] 
    
   session[:return_to] =  url_for(@offre)
       redirect_to new_session_path 
  end  

end
def update
  @offre = Offre.find(params[:id])
  uploaded_io = params[:offre][:offre]
  unless uploaded_io == nil
    File.open(Rails.root.join('public', 'consult',session[:id_projet].to_s,uploaded_io.original_filename), 'wb') do |file|
       file.write(uploaded_io.read)
    end
    @offre.offre = uploaded_io.original_filename 
  end
  if @offre.update(offre_params)
    redirect_to @offre
  else
    render 'edit'
  end
end
def choix_du_projet

end
def selection_du_projet

  @projet = Projet.find_by_id(params["IdInput"])
  session[:id_projet] = @projet.id
  redirect_to new_offre_path
end

private
def offre_params
  params.require(:offre).permit(:id, :offre, :id_fournisseur, :commentaire, :offre, :date_offre, :num_offre, prix_poid_attributes: [:id, :id_offre, :id_projet, :id_item, :prix_local, :poids_local, :prix_importe, :poids_importe, :devise_local, :devise_importe, :remarque , :_destroy] )
end

end
