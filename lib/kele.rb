require 'httparty'
require 'json'

class Kele
  include HTTParty
    base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    response = Kele.post("/sessions", body: { email: email, password: password })

    if response && response["auth_token"]
      @auth_token = response["auth_token"]
      puts "#{email} has sucessfully logged in"
    else
      puts "Login invalid, please try again."
    end
  end

  def get_me
    response = Kele.get("/users/me", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = Kele.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end
end
