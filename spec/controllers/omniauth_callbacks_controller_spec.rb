require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do
  describe '#github' do
    before(:each) do
      github_omniauth
      get :github
    end

    it 'expects omniauth.auth to be be_truthy' do
      expect(request.env['omniauth.auth']).to be_truthy
    end

    it 'redirect to home page' do
      expect(response).to redirect_to root_path
    end
  end

  describe '#google_oauth2' do
    before(:each) do
      google_omniauth
      get :google_oauth2
    end

    it 'expects omniauth.auth to be be_truthy' do
      expect(request.env['omniauth.auth']).to be_truthy
    end

    it 'redirects to home page' do
      expect(response).to redirect_to root_path
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
