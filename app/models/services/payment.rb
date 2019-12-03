module Services
  class Payment < Base
    def initialize(order_id, url)
      @order_id = order_id
      @return_url = url
    end

    def fetch!
      connection = Faraday.new
      @payment_params = set_payment_params
      checksum = generate_checksum
      response = connection.post do |req|
        req.url URI.encode("https://secure.paygate.co.za/payweb3/initiate.trans")
        req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        req.body = URI.encode_www_form(@payment_params.merge(CHECKSUM: Digest::MD5.hexdigest("#{checksum}#{key}")))
      end.body
      pay_request_id = response.split("&PAY_REQUEST_ID=")[1].split("&REFERENCE")[0]
      checkusm_from_response = response.split("&CHECKSUM=")[1]
      
      return  paygate_response = {
        :pay_request_id => pay_request_id,
        :checkusm_from_response => checkusm_from_response,
        :order => set_order
      }
    end

    def set_payment_params
      {
        PAYGATE_ID: "10011072130",
        REFERENCE: set_order.user.full_name,
        AMOUNT: set_order.price.to_i * 100,
        CURRENCY: "ZAR",
        RETURN_URL: "#{@return_url}payments/update?order_id=#{@order_id}",
        TRANSACTION_DATE: Time.now.strftime("%Y-%m-%d %H:%M:%S"),
        LOCALE: "en-za",
        COUNTRY: "ZAF",
        EMAIL: set_order.user.email
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
      order = CleanRequest.find(@order_id)
      return order
    end
  end
end