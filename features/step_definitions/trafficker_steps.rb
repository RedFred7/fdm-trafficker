
require 'rspec'
require 'capybara'
require 'net/http'
require 'json'
require 'sinatra'
require 'open-uri'
require "assert_json"
require 'rake'
require_relative "../../lib/situation"


Before('@accident') do
  puts "------------ running Before hook"
  load File.join(File.dirname(__FILE__), '../..', 'Rakefile')
  Rake::Task['test:seed_redis'].invoke
end

After('@accident') do
  puts "------------ running After hook"
  load File.join(File.dirname(__FILE__), '../..', 'Rakefile')
  Rake::Task['test:clear_redis'].invoke
end

Given(/^that there are (\d+) accident events in the database$/) do |no_of_accidents|
  rs = Situation.find(type: "accident")
  expect(rs.size).to eq(no_of_accidents.to_i)

end

Then(/^I receive a JSON array with (\d+) objects in the response body$/) do |no_of_accidents|
  expect(@response.size).to eq(no_of_accidents.to_i)
  
end

Then(/^a status code of (\d+)$/) do |status_code|
  expect(@response_code).to eq(status_code.to_i)
end


When(/^I GET to "([^"]*)"$/) do |page|
  @page = page
  uri = URI.parse(@page)
  res = Net::HTTP.get_response(uri)
  response_json = res.body
  @response_code = res.code.to_i
  @response = JSON.parse(response_json)
  expect(@response).not_to be nil
end

# Then(/^I see a HTML page with JSON on it$/) do
#   uri = URI.parse(@page)
#   response = Net::HTTP.get(uri)
#   resp = JSON.parse(response)
#   expect(resp).not_to be nil
# end

# Then(/^I see a HTML page with (\d+) piece of JSON$/) do |arg1|
#   pending "finish first few tests"
# end
