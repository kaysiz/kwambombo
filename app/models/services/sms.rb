module Services
    class SMS < Base
      def initialize(messages)
        @messages = JSON.generate({
          "messages" => messages
      })
        p @messages     
      end
  
      def fetch!
        if @messages.length < get_balance
          connection = Faraday.new
          response = connection.post do |req|
            req.url URI.encode("https://rest.smsportal.com/v1/BulkMessages")
            req.headers['Content-Type'] = 'application/json'
            req.headers['Authorization'] = 'Bearer '+ get_token
            req.body = @messages
            p req
          end.body
          p JSON.parse(response, {:symbolize_names=>true})
        else
        end
      end

    private

    def get_balance
      connection = Faraday.new
      response = connection.get do |req|
        req.url URI.encode("https://rest.smsportal.com/v1/Balance")
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = 'Bearer '+ get_token
      end.body
      balance = JSON.parse(response, {:symbolize_names=>true})[:balance].to_i
      return balance
    end
    
    def get_token
      connection = Faraday.new
      response = connection.get do |req|
        req.url URI.encode("https://rest.smsportal.com/v1/Authentication")
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = 'Basic Y2UyNGEzYzMtNDljNS00NmE5LWEzZDQtZmQ1MjFkY2JkNWVlOnM0dEs4dTBHdy9rdDNEK2duZWp1RVdLUXUyencwWnFh'
      end.body
      token = JSON.parse(response, {:symbolize_names=>true})[:token]
      return token
    end
    end
  end