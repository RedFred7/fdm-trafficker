
require 'rspec'
require 'capybara'
require 'net/http'
require 'json'
require 'sinatra'
require 'open-uri'
require_relative "../../lib/situation"


# Before('@accidents') do
#   puts "------------ running Before hook"
#   load File.join(File.dirname(__FILE__), '../..', 'Rakefile')
#   Rake::Task['test:seed_redis'].invoke
# end

# Before('@specific_accident') do
#   puts "------------ running Before hook"
#   load File.join(File.dirname(__FILE__), '../..', 'Rakefile')
#   Rake::Task['test:seed_redis_with_one_object'].invoke
# end

# After do
#   puts "------------ running After hook"
#   load File.join(File.dirname(__FILE__), '../..', 'Rakefile')
#   Rake::Task['test:clear_redis'].invoke
# end





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

Given(/^that there is an accident in the database with the id '([A-Z]{3}\d+)'$/) do |guid|
  @rs = Situation.find(guid: guid)
  expect(@rs.size).to eq(1)
end

Given(/^the version number (\d+)$/) do |version_no|
  expect(@rs.first.version.to_i).to eq(version_no.to_i)
end

Then(/^I receive a JSON object with a version number of (\d+)$/) do |version_no|
	expect(@response[0]['version'].to_i).to eq(version_no.to_i)
end



