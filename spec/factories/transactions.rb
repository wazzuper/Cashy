FactoryBot.define do
  factory :transaction do
    amount '9.99'
    date '2018-03-14 18:59:49'
    comment 'New comment'
    user
  end
end
