class ApplicationController < ActionController::Base
    include Pundit
    include ApplicationHelper
    add_flash_types :info, :error, :warning
    
    before_action :configure_permitted_parameters,
                  if: :devise_controller?

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys:[:avatar, :name, :password, :age, :gender, :address, :email, :longitude, :latitude, :admin])
        devise_parameter_sanitizer.permit(:account_update, keys:[:avatar, :name, :password, :age, :gender, :address, :email, :longitude, :latitude, :admin])
    end
end
