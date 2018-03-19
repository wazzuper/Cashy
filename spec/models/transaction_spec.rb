require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'associations' do
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of :amount }
    it { should validate_presence_of :date }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
    it { should validate_numericality_of(:amount).is_less_than(999999999) }
  end

  describe '#amount=' do
    it 'returns amount with two decimal' do
      transaction = create(:transaction, amount: 22.462342348)

      expect(transaction.amount).to eq(22.46)
    end
  end

  describe '#date=' do
    it 'returns date' do
      transaction = create(:transaction, date: 'Mar 14 2018')

      expect(transaction.date).to eq('14/03/2018')
    end
  end
end
