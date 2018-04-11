class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    handle_oauth_callback
  end

  def google_oauth2
    handle_oauth_callback
  end

  private

  def handle_oauth_callback
    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider)
    else
      redirect_to new_user_registration_url
    end
  end

  def user
    @user ||= OmniAuthService.new(request.env['omniauth.auth']).user
  end

  def provider
   request.env['omniauth.auth'].provider.split('_')[0].humanize
  end
end
