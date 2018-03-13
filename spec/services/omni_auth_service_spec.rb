require 'rails_helper'

RSpec.describe OmniAuthService do
  let(:github_auth) { github_auth_hash }
  let(:google_auth) { google_auth_hash }
  let(:user) { create(:user) }

  describe '#user' do
    context 'when user connect with github' do
      it 'returns a user with github parameters' do
        user = OmniAuthService.new(github_auth).user
        expect(user).to be_a_kind_of(User)
        expect(user.identities.first.provider).to eql('github')
        expect(user.identities.first.uid).to eql('12345')
      end

      it 'returns existing user with two providers' do
        user = OmniAuthService.new(google_auth).user
        user = OmniAuthService.new(github_auth).user
        expect(user.email).to eql('user@email.com')
        expect(user.identities.first.provider).to eql('google')
        expect(user.identities.last.provider).to eql('github')
        expect(user.identities.count).to eq(2)
      end

      it 'returns existing provider' do
        user = OmniAuthService.new(github_auth).user
        user ||= OmniAuthService.new(github_auth).user
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

    context 'when user connect with google' do
      it 'returns a user with google parameters' do
        user = OmniAuthService.new(google_auth).user
        expect(user).to be_a_kind_of(User)
        expect(user.identities.first.provider).to eql('google')
        expect(user.identities.first.uid).to eql('12345')
      end

      it 'returns existing user with two providers' do
        user = OmniAuthService.new(github_auth).user
        user = OmniAuthService.new(google_auth).user
        expect(user.email).to eql('user@email.com')
        expect(user.identities.first.provider).to eql('github')
        expect(user.identities.last.provider).to eql('google')
        expect(user.identities.count).to eq(2)
      end

      it 'returns existing provider' do
        user = OmniAuthService.new(google_auth).user
        user ||= OmniAuthService.new(google_auth).user
        expect(user.identities.first.provider).to eql('google')
        expect(user.identities.count).to eq(1)
      end

      it 'returns a new user with new google parameters' do
        user_with_identity = user.identities.create!(provider: 'google', uid: '777')
        user = OmniAuthService.new(user_with_identity).user
        expect(user.identities.last.provider).to eql('google')
        expect(user.identities.last.uid).to eql('777')
        expect(user.email).to eql('user2@email.com')
      end
    end
  end
end
