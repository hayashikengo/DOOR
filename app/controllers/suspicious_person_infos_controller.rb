class SuspiciousPersonInfosController < ApplicationController
  before_action :set_suspicious_person_info, only: [:show, :edit, :update, :destroy]

  # GET /suspicious_person_infos
  # GET /suspicious_person_infos.json
  def index
    @suspicious_person_infos = SuspiciousPersonInfo.all
  end

  # GET /suspicious_person_infos/1
  # GET /suspicious_person_infos/1.json
  def show
  end

  # GET /suspicious_person_infos/new
  def new
    @suspicious_person_info = SuspiciousPersonInfo.new
  end

  # GET /suspicious_person_infos/1/edit
  def edit
  end

  # POST /suspicious_person_infos
  # POST /suspicious_person_infos.json
  def create
    @suspicious_person_info = SuspiciousPersonInfo.new(suspicious_person_info_params)

    respond_to do |format|
      if @suspicious_person_info.save
        format.html { redirect_to @suspicious_person_info, notice: 'Suspicious person info was successfully created.' }
        format.json { render :show, status: :created, location: @suspicious_person_info }
      else
        format.html { render :new }
        format.json { render json: @suspicious_person_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suspicious_person_infos/1
  # PATCH/PUT /suspicious_person_infos/1.json
  def update
    respond_to do |format|
      if @suspicious_person_info.update(suspicious_person_info_params)
        format.html { redirect_to @suspicious_person_info, notice: 'Suspicious person info was successfully updated.' }
        format.json { render :show, status: :ok, location: @suspicious_person_info }
      else
        format.html { render :edit }
        format.json { render json: @suspicious_person_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suspicious_person_infos/1
  # DELETE /suspicious_person_infos/1.json
  def destroy
    @suspicious_person_info.destroy
    respond_to do |format|
      format.html { redirect_to suspicious_person_infos_url, notice: 'Suspicious person info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suspicious_person_info
      @suspicious_person_info = SuspiciousPersonInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def suspicious_person_info_params
      params.require(:suspicious_person_info).permit(:published_at, :text, :city_id)
    end
end
