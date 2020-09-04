# frozen_string_literal: true
class ApplicationController < ActionController::Base
  
  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end
    
end
