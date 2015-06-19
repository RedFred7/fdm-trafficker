
require 'rspec'
require 'capybara'
require 'net/http'
require 'json'
require 'sinatra'
require 'open-uri'
require_relative "../../lib/situation"


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



Given(/^that there is an accident in the database with the id '([A-Z]{3}\d+)'$/) do |object_guid|
  @rs = Situation.find(guid: object_guid)
  expect(@rs.size).to eq(1)
end

Then(/^the version number (\d+)$/) do |object_version|
  expect(@rs.first.version.to_i).to eq(object_version.to_i)
end


Given(/^that there are (\d+) accident events in the database for '(\w+)'$/) do |no_of_accidents, region|
  rs = Situation.find(location_name: region)
  expect(rs.size).to eq(no_of_accidents.to_i)
end

Then(/^I receive a JSON array with a delay time of xxxxx$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I receive a JSON object with a version number of (\d+)$/) do |version_no|
  expect(@response[0]['version'].to_i).to eq(version_no.to_i)
end

