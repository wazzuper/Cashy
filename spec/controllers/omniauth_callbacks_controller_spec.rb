require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do
  describe '#github' do
    context 'when github email doesn\'t exist' do
      before(:each) do
        github_omniauth
        get :github
        @user = User.find_by(email: 'user@email.com')
      end

      it 'expects omniauth.auth to be be_truthy' do
        expect(request.env['omniauth.auth']).to be_truthy
      end

      it 'creates authentication with github' do
        authentication = @user.identities.find_by(provider: 'github', uid: '12345')
        expect(authentication).to_not be_nil
      end

      it 'redirect to home page' do
        expect(response).to redirect_to root_path
      end
    end

    context 'when github email already exist' do
      before(:each) do
        github_omniauth
        get :github
      end

      it 'expects omniauth.auth to be be_truthy' do
        expect(request.env['omniauth.auth']).to be_truthy
      end

      it 'finds user whith this email' do
        user = Identity.find_by(provider: 'github', uid: '12345').user
        expect(user).to_not be_nil
      end

      it 'redirect to home page' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe '#google_oauth2' do
    context 'when google email doesn\'t exist' do
      before(:each) do
        google_omniauth
        get :google_oauth2
        @user = User.find_by(email: 'user@email.com')
      end

      it 'expects omniauth.auth to be be_truthy' do
        expect(request.env['omniauth.auth']).to be_truthy
      end

      it 'creates authentication with google' do
        authentication = @user.identities.find_by(provider: 'google', uid: '12345')
        expect(authentication).to_not be_nil
      end

      it 'redirects to home page' do
        expect(response).to redirect_to root_path
      end
    end

    context 'when google email already exist' do
      before(:each) do
        google_omniauth
        get :google_oauth2
      end

      it 'expects omniauth.auth to be be_truthy' do
        expect(request.env['omniauth.auth']).to be_truthy
      end

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

def github_omniauth
  request.env['devise.mapping'] = Devise.mappings[:user]
  github_auth_hash
  request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
end

def google_omniauth
  request.env['devise.mapping'] = Devise.mappings[:user]
  google_auth_hash
  request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
end
