module OmniauthMacros
  def github_auth_hash
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(github_hash)
  end

  def google_auth_hash
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new(google_hash)
  end

  private

  def github_hash
    {
      provider: 'github',
      uid: '12345',
      info: {
        email: 'user@email.com'
      },
      credentials: {
        token: 'mock_token',
        secret: 'mock_secret'
      },
      extra: {
        raw_info: { json: 'data' }
      }
    }
  end

  def google_hash
    {
      provider: 'google',
      uid: '12345',
      info: {
        email: 'user@email.com'
      },
      credentials: {
        token: 'mock_token',
        secret: 'mock_secret'
      },
      extra: {
        raw_info: { json: 'data' }
      }
    }
  end
end
