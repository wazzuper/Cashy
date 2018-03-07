class OmniAuthService
  attr_reader :auth_params

  def initialize(auth_params)
    @auth_params = auth_params
  end

  def get_user
    user
  end

  private

  delegate :provider, :uid, to: :auth_params

  def user
    existing_provider = Identity.where(provider: provider, uid: uid).first
    unless existing_provider.eql?(nil)
      existing_provider.user
    else
      create_or_return_user(provider, uid)
    end
  end

  def create_or_return_user(provider, uid)
    user = User.where(email: email).first_or_create! do |user|
      user.assign_attributes(password: password)
      user.skip_confirmation!
    end
    Identity.create!(
      provider: provider,
      uid: uid,
      user_id: user.id
    )
    user
  end

  def email
    auth_params.info.email
  end

  def password
    Devise.friendly_token[0, 20]
  end
end
