class ClovasController < ApplicationController
  before_action :set_clova, only: [:show, :edit, :update, :destroy]

  # GET /clovas
  # GET /clovas.json
  def index
    @clovas = Clova.all
  end

  # GET /clovas/1
  # GET /clovas/1.json
  def show
  end

  # GET /clovas/new
  def new
    @clova = Clova.new
  end

  # GET /clovas/1/edit
  def edit
  end

  # POST /clovas
  # POST /clovas.json
  def create
    @clova = Clova.new(clova_params)

    respond_to do |format|
      if @clova.save
        format.html { redirect_to @clova, notice: 'Clova was successfully created.' }
        format.json { render :show, status: :created, location: @clova }
      else
        format.html { render :new }
        format.json { render json: @clova.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clovas/1
  # PATCH/PUT /clovas/1.json
  def update
    respond_to do |format|
      if @clova.update(clova_params)
        format.html { redirect_to @clova, notice: 'Clova was successfully updated.' }
        format.json { render :show, status: :ok, location: @clova }
      else
        format.html { render :edit }
        format.json { render json: @clova.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clovas/1
  # DELETE /clovas/1.json
  def destroy
    @clova.destroy
    respond_to do |format|
      format.html { redirect_to clovas_url, notice: 'Clova was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clova
      @clova = Clova.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clova_params
      params.require(:clova).permit(:name)
    end
end
