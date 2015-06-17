
Feature: REST API

As a web service
I can access the events page
so that I can get event data as JSON

	@accident
	Scenario: Get accident data
	Given that there are 5 accident events in the database
	When I GET to "http://localhost:1337/accidents"
	Then I receive a JSON array with 5 objects in the response body
	And a status code of 200

	# Scenario: View events per event id in JSON
	# Given that the events are created
	# When I GET to "http://localhost:1337/roadworks/:id"
	# Then I see a HTML page with 1 piece of JSON