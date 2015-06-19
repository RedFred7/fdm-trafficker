require 'rufus-scheduler'
require 'situation'
require_relative 'scraper'
require_relative 'validator'

scheduler = Rufus::Scheduler.new

scheduler.interval '1s' do

  arr = ParseWebXML.parse("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml")

  arr.each do |situation|

    if Validator.validate(situation)

      Situation.new(situation.to_s)

      puts "created"

    else
    	puts "bad code"
    end

  end

end

scheduler.join
