require 'rspec'
require 'capybara'
require 'net/http'
require 'json'
require 'sinatra'
require 'open-uri'
require "assert_json"

Given(/^that the events are created$/) do
	
end

When(/^I GET to "([^"]*)"$/) do |page|
  @page = page
  uri = URI.parse(@page)
  response = Net::HTTP.get(uri).body
  expect(response).not_to be nil
end

Then(/^I see a HTML page with JSON on it$/) do
  uri = URI.parse(@page)
  response = Net::HTTP.get(uri)
  resp = JSON.parse(response)
  expect(resp).not_to be nil
end
