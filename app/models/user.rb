class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  devise :omniauthable, omniauth_providers: %i[google_oauth2 github]
end
