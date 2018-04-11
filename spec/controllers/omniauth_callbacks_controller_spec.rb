require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do
  describe '#github' do
    let(:added_user) { User.find_by(email: 'user@email.com') }
    let(:github_hash) { { provider: 'github', uid: '12345', info: { email: 'user@email.com' } } }
    let(:omni_auth_hash_github) { OmniAuth::AuthHash.new(github_hash) }

    context 'when github email does not exist' do
      before do
        request.env['devise.mapping'] = Devise.mappings[:user]
        request.env['omniauth.auth'] = omni_auth_hash_github
        get :github
      end

      it 'expects omniauth.auth to be be_truthy' do
        expect(request.env['omniauth.auth']).to be_truthy
      end

      it 'creates authentication with github' do
        authentication = added_user.identities.find_by(provider: 'github', uid: '12345')
        expect(authentication).to_not be_nil
      end

      it 'redirects to home page' do
        expect(response).to redirect_to root_path
      end
    end

    context 'when github email already exist' do
      before do
        request.env['devise.mapping'] = Devise.mappings[:user]
        request.env['omniauth.auth'] = omni_auth_hash_github
        get :github
      end

      it { expect(request.env['omniauth.auth']).to be_truthy }

      it 'finds user whith this email' do
        user = Identity.find_by(provider: 'github', uid: '12345').user
        expect(user).to_not be_nil
      end

      it 'redirects to home page' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe '#google_oauth2' do
    let(:added_user) { User.find_by(email: 'user@email.com') }
    let(:google_hash) { { provider: 'google', uid: '12345', info: { email: 'user@email.com' } } }
    let(:omni_auth_hash_google) { OmniAuth::AuthHash.new(google_hash) }

    context 'when google email does not exist' do
      before do
        request.env['devise.mapping'] = Devise.mappings[:user]
        request.env['omniauth.auth'] = omni_auth_hash_google
        get :google_oauth2
      end

      it { expect(request.env['omniauth.auth']).to be_truthy }

      it 'creates authentication with google' do
        authentication = added_user.identities.find_by(provider: 'google', uid: '12345')
        expect(authentication).to_not be_nil
      end

      it 'redirects to home page' do
        expect(response).to redirect_to root_path
      end
    end

    context 'when google email already exist' do
      before do
        request.env['devise.mapping'] = Devise.mappings[:user]
        request.env['omniauth.auth'] = omni_auth_hash_google
        get :google_oauth2
      end

      it { expect(request.env['omniauth.auth']).to be_truthy }

      it 'finds user whith this email' do
        user = Identity.find_by(provider: 'google', uid: '12345').user
        expect(user).to_not be_nil
      end

      it 'redirects to home page' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
