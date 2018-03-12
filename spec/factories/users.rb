FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@email.com" }
    password 'secret123!@#'
    password_confirmation 'secret123!@#'
    confirmed_at Time.zone.today
  end
end
