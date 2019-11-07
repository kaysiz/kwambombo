class RequestFeedbacksController < ApplicationController
  before_action :set_request_feedback, only: [:show, :edit, :update, :destroy]

  # GET /request_feedbacks
  # GET /request_feedbacks.json
  def index
    @request_feedbacks = RequestFeedback.all
  end

  # GET /request_feedbacks/1
  # GET /request_feedbacks/1.json
  def show
  end

  # GET /request_feedbacks/new
  def new
    @request_feedback = RequestFeedback.new
  end

  # GET /request_feedbacks/1/edit
  def edit
  end

  # POST /request_feedbacks
  # POST /request_feedbacks.json
  def create
    @request_feedback = RequestFeedback.new(request_feedback_params)

    respond_to do |format|
      if @request_feedback.save
        format.html { redirect_to @request_feedback, notice: 'Request feedback was successfully created.' }
        format.json { render :show, status: :created, location: @request_feedback }
      else
        format.html { render :new }
        format.json { render json: @request_feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /request_feedbacks/1
  # PATCH/PUT /request_feedbacks/1.json
  def update
    respond_to do |format|
      if @request_feedback.update(request_feedback_params)
        format.html { redirect_to @request_feedback, notice: 'Request feedback was successfully updated.' }
        format.json { render :show, status: :ok, location: @request_feedback }
      else
        format.html { render :edit }
        format.json { render json: @request_feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_feedbacks/1
  # DELETE /request_feedbacks/1.json
  def destroy
    @request_feedback.destroy
    respond_to do |format|
      format.html { redirect_to request_feedbacks_url, notice: 'Request feedback was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request_feedback
      @request_feedback = RequestFeedback.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_feedback_params
      params.require(:request_feedback).permit(:rating, :comment)
    end
end
