require 'rufus-scheduler'
#require 'situation'
require_relative 'scraper'
require_relative 'validator'

class Scheduler
  def self.start
    scheduler = Rufus::Scheduler.new
    scheduler.every '10m', :first_at => 0.5 do |job|
      arr = ParseWebXML.parse("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml")
      arr.each do |situation|
        if Validator.validate(situation)
          #Situation.initialize(situation.to_s)
        else
          job.next_time = Time.now + 2 * 60
        end
      end
    end
    scheduler.join
  end
end


