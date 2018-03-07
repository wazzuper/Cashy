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
    unless user.eql?(nil)
      user.user
    else
      user = User.where(email: email).first_or_create! do |user|
        user.password = Devise.friendly_token[0, 20]
        user.skip_confirmation!
      end
      Identity.create!(
        provider: provider,
        uid: uid,
        user_id: user.id
      )
      user
    end
  end

  def email
    auth_params.info.email
  end
end
