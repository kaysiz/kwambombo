class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  # before_action :set_order, only: [:set_payment_params]
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
    initiate
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

    def initiate
      connection = Faraday.new
      @payment_params = set_payment_params
      checksum = generate_checksum
      response = connection.post do |req|
        req.url URI.encode("https://secure.paygate.co.za/payweb3/initiate.trans")
        req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        req.body = URI.encode_www_form(@payment_params.merge(CHECKSUM: Digest::MD5.hexdigest("#{checksum}#{key}")))
      end.body
      p response
      pay_request_id = response.split("&PAY_REQUEST_ID=")[1].split("&REFERENCE")[0]
      checkusm_from_response = response.split("&CHECKSUM=")[1]
      
      @paygate_response = {
        :pay_request_id => pay_request_id,
        :checkusm_from_response => checkusm_from_response
      }
    end

    def set_payment_params
      p order
      return {
        PAYGATE_ID: "10011072130",
        REFERENCE: 'kaysiz',
        AMOUNT: 45,
        CURRENCY: "ZAR",
        RETURN_URL: "http://localhost:3000/payments/update?order_id=23",
        TRANSACTION_DATE: Time.now.strftime("%Y-%m-%d %H:%M:%S"),
        LOCALE: "en-za",
        COUNTRY: "ZAF",
        EMAIL: 'ksiziva@gmail.com'
      }
    end

    def generate_checksum
      set_payment_params.map{|k,v| "#{v}"}.join('')
    end

    def key
      "secret"
    end
  
    def paygate_id
      "1029122100018"
    end

    def set_order
      order = CleanRequest.find(params[:id])
    end
end
