require 'rufus-scheduler'
require 'open-uri'
require 'nokogiri'

class ParseWebXML
  def self.parse(xmlurl)
    array = []
    doc = Nokogiri::HTML(open(xmlurl))
    doc.css("situation").each do |situation|
      array << situation
    end
    array
  end
end

scheduler = Rufus::Scheduler.new
scheduler.interval '10m' do
  arr = ParseWebXML.parse("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml")
  arr.each do |situation| 
  	Situation.new(situation.to_s)
  end
end

scheduler.join
