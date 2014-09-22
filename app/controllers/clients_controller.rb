class ClientsController < ApplicationController
   before_action :set_client, only: [:show, :edit, :update, :destroy]
	def index 
		@clients_grid = initialize_grid(Client, enable_export_to_csv: true,
  csv_file_name: 'clients', csv_field_separator: ';', name: 'clients', order: :nom,
  order_direction: 'asc')
    export_grid_if_requested
	end
	def show
    #génère les tables
		@client = Client.joins('LEFT OUTER JOIN t_projet ON t_projet.id_client = t_client.id').joins('LEFT OUTER JOIN t_conditions ON t_conditions.id = t_projet.id_conditions').find_by_id(params[:id])
		@clients = Client.all
    @projets = Projet.joins('LEFT OUTER JOIN t_conditions ON t_conditions.id = t_projet.id_conditions').joins('LEFT OUTER JOIN t_type_projet ON t_type_projet.id = t_projet.id_typeprojet')
    @projet = initialize_grid(@projets,csv_field_separator: ';', csv_file_name: ('Client' + @client.nom), :conditions => ['id_client = ?', @client.id])
    export_grid_if_requested

	end
def destroy
  @client = Client.find(params[:id])
  @client.destroy
 
  redirect_to clients_path
end
 	def new
 		@client = Client.new
    # Vérifie si l'utilisateur possède les droits d'écriture
  unless session[:ecriture] 
    
   session[:return_to] =  url_for(@client)
       redirect_to new_session_path 
  end
 	end
def edit
  @client = Client.find_by_id(params[:id])
      # Vérifie si l'utilisateur possède les droits d'écriture

  unless session[:ecriture] 

   session[:return_to] =  url_for(@client)
       redirect_to new_session_path 
 end
end
  def create

    @client = Client.new(client_params)
    
    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'client was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

	private
      # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end
  def client_params
    params.require(:client).permit(:id, :nom, :raison_sociale, :adresse)
  end



end
