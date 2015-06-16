
Feature: REST API

As a web service
I can access the events page
so that I can see the events in JSON

	Scenario: View events in JSON
	Given that the events are created
	When I GET to "http://localhost:1337/events/unplanned.json"
	Then I see a HTML page with JSON on it