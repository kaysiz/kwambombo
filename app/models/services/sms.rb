module Services
    class SMS < Base
      def initialize(number)
        @number = number
        @base_url = ""
        
      end
  
      def fetch!
        
      end

      def get_token

        site = RestClient::Resource.new(freshdesk_api_url, user_name_or_api_key, password_or_x)
		
        begin
          response = site.post(json_payload, :content_type=>'application/json')
          render json: {status: 'SUCCESS'}, status: :ok
        rescue RestClient::Exception => exception
          puts 'API Error: Your request is not successful. If you are not able to debug this error properly, mail us at support@freshdesk.com with the follwing X-Request-Id'
          puts "X-Request-Id : #{exception.response.headers[:x_request_id]}"
          puts "Response Code: #{exception.response.code} Response Body: #{exception.response.body} "
        end
      end
  
    private
  
    end
  end