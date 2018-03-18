class Transaction < ApplicationRecord
  belongs_to :user

  validates :amount, :date, presence: true
  validates :amount, numericality: { greater_than: 0, less_than: 999999999 }

  def amount=(value)
    write_attribute(:amount, return_amount_with_two_decimal(value)) if value
  end

  private

  def return_amount_with_two_decimal(value)
    if value.to_s.include?('.')
      num = value.to_s.split('.')
      num[1] = num[1][0..1]
      num.join('.').to_f
    else
      value
    end
  end
end
