class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'GitHub')
    else
      return_to_registration_page
    end
  end

  def google_oauth2
    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Google')
    else
      return_to_registration_page
    end
  end

  private

  def user
    @user ||= OmniAuthService.new(request.env['omniauth.auth']).get_user
  end

  def return_to_registration_page
    redirect_to new_user_registration_url, alert: user.errors.full_messages.join("")
  end
end
