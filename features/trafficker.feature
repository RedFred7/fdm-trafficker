
Feature: REST API

As a web service
I can access the events page
so that I can get event data as JSON

	@accidents
	Scenario: Get all accident data
	Given that there are 6 accident events in the database
	When I GET to "http://localhost:1337/accidents"
	Then I receive a JSON array with 6 objects in the response body
	And a status code of 200

	@specific_accident
	Scenario: Get specific accident data
	Given that there is an accident in the database with the id 'ABC1234'
	And the version number 1234
	When I GET to "http://localhost:1337/accidents/ABC1234"
	Then I receive a JSON object with a version number of 1234
	And a status code of 200
