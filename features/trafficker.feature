
Feature: REST API

As a web service
I can access the events page
so that I can get event data as JSON

	@accident
	Scenario: Get all accident data
	Given that there are 5 accident events in the database
	When I GET to "http://localhost:1337/accidents"
	Then I receive a JSON array with 5 objects in the response body
	And a status code of 200

	# Scenario: Get specific accident data
	# Given that there is an accident in the database with the id 'ABC1234'
	# When I GET to "http://localhost:1337/roadworks/ABC1234"
	# Then I receive a JSON array with 5 objects in the response body