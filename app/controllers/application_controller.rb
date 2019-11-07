class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :phone_number, :business_name, :address])
        devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :phone_number, :business_name, :address])
      end
end
