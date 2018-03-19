require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:user) { create(:user) }
  let(:transaction) { create(:transaction) }

  before do
    sign_in(user)
  end

  describe '#create' do
    context 'with valid attributes' do
      it 'saves the new transaction in the database' do
        expect { post :create, params: { transaction: attributes_for(:transaction) } }.to change(Transaction, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the transaction' do
        expect { post :create, params: { transaction: attributes_for(:invalid_transaction) } }.to_not change(Transaction, :count)
      end

      it 'redirects to main page' do
        post :create, params: { transaction: attributes_for(:invalid_transaction) }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
