# @c.j.chandler

require 'rspec'
require 'capybara'
require 'net/http'
require 'json'
require 'sinatra'
require 'open-uri'
require "assert_json"
require_relative "../../lib/situation"

situation = Situation.new
attributes = double(attributes)

Given(/^that the events are created$/) do
  expect(situation.attributes).to be_an_instance_of Hash
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

Then(/^I see a HTML page with (\d+) piece of JSON$/) do |arg1|
	pending "finish first few tests"
end
