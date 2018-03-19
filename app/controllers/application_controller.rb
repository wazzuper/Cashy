class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(email password))
    devise_parameter_sanitizer.permit(:account_update, keys:
      %i(email full_name password avatar avatar_cache remove_avatar))
  end

  def user_not_authorized
    flash[:alert] = t('session.not_auth')
    redirect_to(request.referer || root_path)
  end
end
