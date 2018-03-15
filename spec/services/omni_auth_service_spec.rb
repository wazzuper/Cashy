require 'rails_helper'

RSpec.describe OmniAuthService do
  let(:github_hash) { { provider: 'github', uid: '12345', info: { email: 'user@email.com' } } }
  let(:google_hash) { { provider: 'google', uid: '12345', info: { email: 'user@email.com' } } }
  let(:omni_auth_hash_github) do
    OmniAuth::AuthHash.new(github_hash)
  end
  let(:omni_auth_hash_google) do
    OmniAuth::AuthHash.new(google_hash)
  end
  let(:user) { create(:user) }

  describe '#user' do
    context 'when user connect with github' do
      it 'returns a user with github parameters' do
        user = OmniAuthService.new(omni_auth_hash_github).user
        expect(user).to be_a_kind_of(User)
        expect(user.identities.first.provider).to eql('github')
        expect(user.identities.first.uid).to eql('12345')
      end

      it 'returns existing user with two providers' do
        user = OmniAuthService.new(omni_auth_hash_google).user
        user = OmniAuthService.new(omni_auth_hash_github).user
        expect(user.identities.first.provider).to eql('google')
        expect(user.identities.last.provider).to eql('github')
        expect(user.identities.count).to eq(2)
      end

      it 'returns existing provider' do
        user = OmniAuthService.new(omni_auth_hash_github).user
        user ||= OmniAuthService.new(omni_auth_hash_github).user
        expect(user.identities.first.provider).to eql('github')
        expect(user.identities.count).to eq(1)
      end

      it 'returns a new user with new github parameters' do
        user_with_identity = user.identities.create!(provider: 'github', uid: '555')
        user = OmniAuthService.new(user_with_identity).user
        expect(user.identities.last.provider).to eql('github')
        expect(user.identities.last.uid).to eql('555')
        expect(user.email).to eql('user1@email.com')
      end
    end
  end
end
