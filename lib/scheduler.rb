require 'rufus-scheduler'
require 'nokogiri'
require 'open-uri'
require_relative 'situation'
require_relative 'scraper'
require_relative 'validator'

scheduler = Rufus::Scheduler.new

scheduler.every '10m', :first => :now  do |job|

  arr = ParseWebXML.parse("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml")

  arr.each do |situation|

    if Validator.validate(situation)
      doc = Nokogiri::XML( situation.to_s )
      rs = Situation.find(guid: doc.xpath("/situation/@id").text)
      rs.first.delete if rs.size > 0
      Situation.initialize(situation.to_s).save
      puts "put"
    else
      job.next_time = Time.now + 3 * 60
    end

  end
end

scheduler.join
