class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(email password))
    devise_parameter_sanitizer.permit(:account_update, keys:
      %i(email full_name password avatar avatar_cache remove_avatar))
  end
end
