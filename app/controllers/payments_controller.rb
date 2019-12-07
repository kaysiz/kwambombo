class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update_payment]
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def order
    @paygate_response = Services::Payment.new(params[:id], root_url).fetch!
    params_payment = {
      checksum: @paygate_response[:checkusm_from_response],
      amount: @paygate_response[:order].price.to_f,
      payment_method: 'online using credit card',
      payment_request_id: @paygate_response[:pay_request_id],
      status: 'pending'
    }
    Payment.new(params_payment).save
  end

  def update_payment
    request_id = params[:PAY_REQUEST_ID]
    transaction_status = params[:TRANSACTION_STATUS]
    transaction_statuses = {
        '0' =>'Not Done',
        '1' =>'Approved',
        '2' =>'Declined',
        '3' =>'Cancelled',
        '4' =>'User Cancelled',
        '5' =>'Received by PayGate',
        '7' =>'Settlement Voided'
    }
    status = transaction_statuses[transaction_status]
    @payment = Payment.find_by(payment_request_id: request_id)
    @order = CleanRequest.find(params[:id])
    if @payment.present? && @payment.update(status: status) && @order.present? && @order.update(payment_status: status)
      @message = status
    else
      @message = 'Something went wrong, please try again!'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.fetch(:payment, {})
    end
end
