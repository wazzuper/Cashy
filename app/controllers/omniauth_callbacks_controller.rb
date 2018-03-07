class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :user

  def github
    if user
      sign_in_and_redirect user, event: :authentication
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'GitHub')
    else
      #session['devise.github_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    if user
      sign_in_and_redirect user, event: :authentication
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Google')
    else
      #session['devise.google_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  private

  def user
    @user ||= OmniAuthService.new(request.env['omniauth.auth']).user
  end
end
