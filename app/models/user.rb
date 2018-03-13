class User < ApplicationRecord
  has_many :identities, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  devise :omniauthable, omniauth_providers: %i[google_oauth2 github]

  mount_uploader :avatar, AvatarUploader
end
