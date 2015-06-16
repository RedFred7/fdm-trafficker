require 'ohm'
require 'open-uri'
require 'nokogiri'
require 'date'
require_relative 'my_modules/utils'
require_relative 'scraper'

class Situation < Ohm::Model
  attribute :guid
  unique :guid
  attribute :version
  attribute :time
  attribute :type
  index :type
  attribute :date
  attribute :comment
  attribute :location_name
  attribute :location_coordinates
  attribute :traffic_type
  attribute :delay_time
  attribute :capacityRemaining
  attribute :trafficRestrictionType

  def self.initialize(xml_situation)
  	doc = Nokogiri::XML( xml_situation )
  	@doc = doc.xpath("/situation")
    Situation.new(type: 'roadworks',date: self.get_date)
  end


  def self.get_date
    str = @doc.xpath("situationRecord/situationRecordCreationTime").text
    p str
    date = DateTime.parse str
  end

end

arr = ParseWebXML.parse("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml")
#p arr[1].to_s  
s = Situation.initialize(arr[1].to_s)
#p s.date

