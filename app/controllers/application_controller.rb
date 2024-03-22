class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    user_fields = %w[name phone zipcode address1 address2]
    user_fields.push({ is_marketing: [] })

    devise_parameter_sanitizer.permit(:sign_up, keys: user_fields)
    devise_parameter_sanitizer.permit(:account_update, keys: user_fields)
  end

  def authenticate_admin_user!
    redirect_to new_admin_user_session_path unless admin_user_signed_in?
  end
end
