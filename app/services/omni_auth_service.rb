class OmniAuthService
  attr_reader :auth_params

  def initialize(auth_params)
    @auth_params = auth_params
  end

  def user
    User.where(provider: provider, uid: uid).first_or_create! do |user|
      user.assign_attributes(email: email, password: password)
      user.skip_confirmation!
    end
  end

  private
  
  delegate :provider, :uid, to: :auth_params

  def email
    auth_params.info.email
  end

  def password
    Devise.friendly_token[0, 20]
  end
end
