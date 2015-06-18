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


get "/accidents" do
  rs = Situation.find(type: "accident")
  results = []
  if rs.size > 0
    rs.each do |r|
      results << r.attributes
    end
    status 200
    body << results.to_json
    # slim :accidents
  else
    # slim :error
  end
  body
end

get "accidents/:region" do
   region_average = {'delay_time' => AggregateFunctions.new.average_where(params["region"])}.to_json
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



delete "/accidents" do
  res = Situation.find(type: "accident")
  res.each {|object| object.delete}
end

not_found do
  slim :error
end
