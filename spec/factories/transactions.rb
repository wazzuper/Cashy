FactoryBot.define do
  factory :transaction do
    amount '9.99'
    date '2018-03-14 18:59:49'
    comment 'New comment'
    user
  end

  factory :invalid_transaction, class: 'Transaction' do
    amount nil
    date '2018-03-14 18:59:49'
    user
  end
end
