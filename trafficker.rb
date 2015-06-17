# @c.j.chandler

require "sinatra"
require "json"
require "rspec-mocks"
require_relative "lib/situation"

configure :development do
  set :port, 1337
  enable :sessions
  set :username, "admin"
  set :password, "capybara"
end

situation = Situation.new

get "/" do
  slim :home
end

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

get "/roadworks" do
  if !Situation.find(type: "roadworks").nil?
    @roadworks = situation.attributes.to_json
    body << @roadworks
    slim :roadworks
  else
    slim :error
  end
end

get "/accidents" do
  if !Situation.find(type: "accident").nil?
    @accidents = situation.attributes.to_json
    body << @accidents
    slim :accidents
  else
    slim :error
  end
end

get "/roadworks/:id" do
  @id = params[:id]
  if situation.attributes[:id].to_s == @id.to_s
    @roadworks_id = situation.attributes
    body << @roadworks_id unless Situation.find(type: "roadworks").nil?
    slim "roadworks_#{@id}".to_sym
  else
    slim :error
  end
end

get "/accidents/:id" do
  @id = params[:id]
  if situation.attributes[:id].to_s == @id.to_s
    @accidents_id = situation.attributes
    body << @accidents_id unless Situation.find(type: "accident").nil?
    slim "accidents_#{@id}".to_sym
  else
    slim :error
  end
end

delete "/roadworks" do
  res = Situation.find(type: "roadworks")
  res.each {|object| object.delete}
end

delete "/accidents" do
  res = Situation.find(type: "accident")
  res.each {|object| object.delete}
end

not_found do
  slim :error
end
