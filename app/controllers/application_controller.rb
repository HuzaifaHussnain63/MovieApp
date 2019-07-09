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

  def authenticate_admin
    return true if user_signed_in? && current_user.admin?
    flash[:alert] = "You need to be admin to access this section"
    redirect_to home_index_path
  end

  def set_actor
    @actor = Actor.find(params[:actor_id])
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
