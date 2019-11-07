class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all
    initiate
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
      @payment_params = payment_params
      @checksum = generate_checksum
      response = connection.post do |req|
        req.url URI.encode("https://secure.paygate.co.za/payweb3/initiate.trans")
        req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        # req.body = URI.encode_www_form(@payment_params.merge(CHECKSUM: Digest::MD5.hexdigest(@checksum)))
      end.body
      Hash[CGI.parse(response).map {|key,values| [key.to_sym, values[0]||true]}]
    end

    def order_params
      {
        PAYGATE_ID: paygate_id,
        REFERENCE: 'kaysiz',
        AMOUNT: 45,
        CURRENCY: "ZAR",
        RETURN_URL: "http://localhost:3000/payments/update?order_id=" + order.id.to_s,
        TRANSACTION_DATE: Time.now.strftime("%Y-%m-%d %H:%M:%S"),
        LOCALE: "en-za",
        COUNTRY: "ZAF",
        EMAIL: order.email
      }
    end

    def generate_checksum
      result = ""
      @payment_params.each do |k,v|
        result += v.to_s
      end
      result += key
    end

    def key
      "AXtyAK4E3FEPsHLWjGoqEC4cvus4"
    end
  
    def paygate_id
      "1029122100018"
    end
end
