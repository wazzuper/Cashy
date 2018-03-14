class Transaction < ApplicationRecord
  belongs_to :user

  validates :amount, :date, presence: true
  validates :amount, length: { maximum: 999999999 }
end
