class CodificationController < ApplicationController
  before_action :set_codification, only: [:show, :edit, :update, :destroy]

  # GET /codification
  # GET /codification.json
  def index
    @codification = Codification.all
        #génère les tables
    @codification_g = initialize_grid(Codification.all, csv_file_name: 'codification', csv_field_separator: ';', name: 'codification')
    export_grid_if_requested
  end

  # GET /codification/1
  # GET /codification/1.json
  def show
  end

  # GET /codification/new
  def new
    @codification = Codification.new
  end

  # GET /codification/1/edit
  def edit
  end
  def recherche_des_items
#génère les tables
    @items_grid = initialize_grid(Item, :conditions => ['code_planus = ?', params[:id]],  csv_file_name: 'item', csv_field_separator: ';', name: 'item')
    export_grid_if_requested
    @codification = Codification.find_by_id(params[:id])
  end
  def recherche_des_items_avec_offre
#génère les tables
  @items_offre_grid = initialize_grid(Item, :conditions => ['code_planus = ?', params[:id]], :joins => :prix_poid, csv_file_name: 'item_offre', name: 'item_offre', csv_field_separator: ';')
    export_grid_if_requested
      @codification = Codification.find_by_id(params[:id])
  end
  # POST /codification
  # POST /codification.json
  def create
    @codification = Codification.new(codification_params)

    respond_to do |format|
      if @codification.save
        format.html { redirect_to @codification, notice: 'Codification was successfully created.' }
        format.json { render :show, status: :created, location: @codification }
      else
        format.html { render :new }
        format.json { render json: @codification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /codification/1
  # PATCH/PUT /codification/1.json
  def update
    respond_to do |format|
      if @codification.update(codification_params)
        format.html { redirect_to @codification, notice: 'Codification was successfully updated.' }
        format.json { render :show, status: :ok, location: @codification }
      else
        format.html { render :edit }
        format.json { render json: @codification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /codification/1
  # DELETE /codification/1.json
  def destroy
    @codification.destroy
    respond_to do |format|
      format.html { redirect_to codification_index_url, notice: 'Codification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_codification
      @codification = Codification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def codification_params
      params[:codification].permit(:designation_fr, :designation_en, :planus, :holcim_fr, :holcim_en, :lafarge, :peg, :client_1, :client_2, :client_3, :client_4, :client_5, :client_6, :client_7, :client_8, :client_9, :client_10, :client_11, :client_12, :client_13, :client_14, :client_15, :client_16, :client_17, :client_18, :client_19, :client_20)
    end
end