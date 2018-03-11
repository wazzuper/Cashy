require 'rails_helper'

RSpec.describe OmniAuthService do
  let(:github_auth) { github_auth_hash }
  let(:google_auth) { google_auth_hash }

  describe '#user for github' do
    it 'returns a user' do
      user = OmniAuthService.new(github_auth).user
      expect(user).to be_a_kind_of(User)
    end
  end

  describe '#user for google' do
    it 'returns a user' do
      user = OmniAuthService.new(google_auth).user
      expect(user).to be_a_kind_of(User)
    end
  end
end
