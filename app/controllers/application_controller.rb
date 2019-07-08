class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :update_permitted_parameters, if: :devise_controller?
  before_action :validate_resource, if: :devise_controller?, only: [:update]
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
  end

  def update_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
  end

  private
  def validate_resource
   unless update_resource(resource, account_update_params.except(:avatar))
     clean_up_passwords resource
     set_minimum_password_length
     respond_with resource
   end
 end

end
