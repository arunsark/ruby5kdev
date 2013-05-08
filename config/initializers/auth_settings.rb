module RunKeeper
  if Rails.env.production?
    REDIRECT_URI = "http://ruby5k.in/auth_callbacks/run_keeper_auth".freeze
  else
    REDIRECT_URI = "http://localhost:3000/auth_callbacks/run_keeper_auth".freeze
  end
  AUTHORIZATION_URL = 'https://runkeeper.com/apps/authorize'.freeze
  API_END_POINT = 'https://api.runkeeper.com'.freeze
  ACCESS_TOKEN_URL = 'https://runkeeper.com/apps/token'.freeze
  CLIENT_ID = ENV['RUNKEEPER_CLIENT_ID']
  CLIENT_SECRET = ENV['RUNKEEPER_CLIENT_SECRET']
end
