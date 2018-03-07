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
    user = Identity.where(provider: provider, uid: uid).first
    unless user.nil?
      user.user
    else
      registered_user = User.where(email: auth_params.info.email).first
      unless registered_user.nil?
        Identity.new(
          provider: provider,
          uid: uid,
          user_id: registered_user.id
        )
        register_user(registered_user)
      else
        user = User.new(
          email: auth_params.info.email,
          password: Devise.friendly_token[0, 20]
        )
        user_provider = Identity.new(
          provider: provider,
          uid: uid,
          user_id: user.id
        )
        create_provider(user_provider)
        create_user(user)
      end
    end
  end

  def create_user(user)
    user.skip_confirmation!
    user.save
    user
  end

  def create_provider(provider)
    provider.save
    provider
  end

  def register_user(user)
    user.save
    user
  end
end
