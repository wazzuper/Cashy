class OmniAuthService
  attr_reader :auth_params

  def initialize(auth_params)
    @auth_params = auth_params
  end

  def user
    existing_provider = Identity.find_by(provider: provider, uid: uid)
    if existing_provider.eql?(nil)
      create_or_return_user(provider, uid)
    else
      existing_provider.user
    end
  end

  private

  delegate :provider, :uid, to: :auth_params

  def create_or_return_user(provider, uid)
    user = User.where(email: email).first_or_create! do |user|
      user.assign_attributes(password: password)
      user.skip_confirmation!
    end
    user.identities.create!(
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
