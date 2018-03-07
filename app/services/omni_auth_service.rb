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
    user = User.where(provider: provider, uid: uid).first
    user ||= User.new(
      provider: provider,
      uid: uid,
      email: auth_params.info.email,
      password: Devise.friendly_token[0, 20]
    )
    create_user(user)
  end

  def create_user(user)
    user.skip_confirmation!
    user.save
    user
  end
end
