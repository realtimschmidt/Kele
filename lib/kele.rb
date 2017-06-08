require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    response = self.class.post('/sessions', body: { email: email, password: password })
    puts response.code

    if response.code == 200
      puts 'Welcome'
    else
      puts 'Invalid Credentials'
    end

    @auth_token = response['auth_token']
  end

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    @user_info = JSON.parse(response.body)
  end
end
