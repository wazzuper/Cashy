class OmniAuthService
  attr_reader :auth_params

  def initialize(auth_params)
    @auth_params = auth_params
  end

  def user
    Identity.find_by!(provider: provider, uid: uid).user
  rescue ActiveRecord::RecordNotFound
    find_or_create_user
  end

  private

  delegate :provider, :uid, to: :auth_params

  def find_or_create_user
    user = User.where(email: email).first_or_create! do |user|
      user.assign_attributes(password: password)
      user.skip_confirmation!
    end
    user.identities.create!(
      provider: provider,
      uid: uid
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
