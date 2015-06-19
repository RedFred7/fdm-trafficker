# @c.j.chandler

require "sinatra"
require "json"
require_relative "lib/situation"

configure :development do
  set :port, 1337
  enable :sessions
  set :username, "admin"
  set :password, "capybara"
end

situation = Situation.new


get "/login" do
  slim :login
end

post "/login" do
  @username = params[:username]
  @password = params[:password]
end

get "/register" do
  slim :register
end

post "/register" do
  @firstname = params[:firstname]
  @lastname = params[:lastname]
  @username = params[:username]
  @password = params[:password]
  @email = params[:email]
end

get "/events" do
  slim :events
end

get "/test" do
  
end


get "/" do 
  slim :accident_map
  
end

get "/accidents" do
  rs = Situation.find(type: "accident")
  results = []
  if rs.size > 0
    rs.each do |r|
      results << r.attributes
    end
    status 200
    # slim :accidents
  else
    status 500
    # slim :error
  end
  body << results.to_json
end



get "/accidents/:guid" do
  rs = Situation.find(guid: params[:guid])
  results = []
  if rs.size == 1
    results << rs.first.attributes
    status 200
  else
    status 500
  end
  body << results.to_json
end

get "/accidents/:region" do
  {dealy_average: 2400}.to_json
end



delete "/accidents" do
  res = Situation.find(type: "accident")
  res.each {|object| object.delete}
end

not_found do
  slim :error
end
