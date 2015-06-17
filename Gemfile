# A sample Gemfile
source "https://rubygems.org"


#we can specify which ruby version to use on the project in here

ruby "2.2.1"
gem "whenever"
# gem "rails"
gem "slim"
gem "sinatra" #rack is a gem dependency of sinatra so we don't need to write gem "rack"
gem "cucumber"
gem "ohm"
gem "nokogiri"
gem "assert_json"
gem "json"
group :developement do
	#reload sinatra every time a change is made to the code
	gem "rerun"
	#for debugging
	gem "byebug"
	#for documentation
	gem "yard", "~>0.8"
end

group :developement, :testing do
	#for unit testing
	gem "rspec", "~>3.2"
	#allows interaction with web browsers...uses rack driver by its self...but it doesn't react well to js based pages
	gem "capybara"
#this is why we use javascript
	gem "selenium-webdriver"
	gem "rspec-mocks"

end

group :testing do 
	#test coverage
	gem "simplecov"
end