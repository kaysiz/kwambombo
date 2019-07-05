class CleanRequestsController < ApplicationController
  before_action :authenticate
  before_action :set_clean_request, only: [:show, :edit, :update, :destroy]

  # GET /clean_requests
  # GET /clean_requests.json
  def index
    if admin_signed_in?
      @clean_requests = CleanRequest.all
    end
    if user_signed_in?
      @clean_requests = CleanRequest.where(user_id: current_user.id).order(created_at: :desc)
    end
  end

  # GET /clean_requests/1
  # GET /clean_requests/1.json
  def show
  end

  # GET /clean_requests/new
  def new
    @clean_request = CleanRequest.new
  end

  # GET /clean_requests/1/edit
  def edit
  end

  # POST /clean_requests
  # POST /clean_requests.json
  def create
    @clean_request = CleanRequest.new(clean_request_params)

    respond_to do |format|
      if @clean_request.save
        format.html { redirect_to @clean_request, notice: 'Clean request was successfully created.' }
        format.json { render :show, status: :created, location: @clean_request }
      else
        format.html { render :new }
        format.json { render json: @clean_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clean_requests/1
  # PATCH/PUT /clean_requests/1.json
  def update
    respond_to do |format|
      if @clean_request.update(clean_request_params)
        format.html { redirect_to @clean_request, notice: 'Clean request was successfully updated.' }
        format.json { render :show, status: :ok, location: @clean_request }
      else
        format.html { render :edit }
        format.json { render json: @clean_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clean_requests/1
  # DELETE /clean_requests/1.json
  def destroy
    @clean_request.destroy
    respond_to do |format|
      format.html { redirect_to clean_requests_url, notice: 'Clean request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clean_request
      @clean_request = CleanRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clean_request_params
      params.permit![:clean_request]
    end

    def authenticate
      if admin_signed_in?
        authenticate_admin!        
      else
        authenticate_user!
      end
    end
end
