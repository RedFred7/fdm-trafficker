require 'ohm'
require 'open-uri'
require 'nokogiri'
require 'date'
require_relative 'modules/utils'
require_relative 'scraper'
require_relative 'region_finder'

class Situation < Ohm::Model
  attribute :guid
  unique :guid
  index :guid
  attribute :version
  attribute :time
  attribute :type
  index :type
  attribute :date
  attribute :comment
  attribute :location_name
  index :location_name
  attribute :latitude
  attribute :longitude
  attribute :traffic_type
  attribute :delay_time
  attribute :capacityRemaining
  attribute :trafficRestrictionType

  def self.initialize(xml_situation)
    @doc = Nokogiri::XML( xml_situation )
    Situation.new(guid: self.get_guid, version: self.get_version, time: self.get_time,
                  type: self.get_type, date: self.get_date, comment: self.get_comment,
                  location_name: self.get_location_name, latitude: self.get_latitude,
                  longitude: self.get_longitude, traffic_type: self.get_traffic_type,
                  delay_time: self.get_delay_time, capacityRemaining: self.get_capacityRemaining,
                  trafficRestrictionType: self.get_trafficRestrictionType
                  )
  end

  def self.get_guid
    @doc.xpath("/situation/@id").text
  end

  def self.get_version
    @doc.xpath("/situation/situationrecord/situationrecordversion").text
  end

  def self.get_time
    str = @doc.xpath("/situation/situationrecord/situationrecordcreationtime").text
    date = DateTime.parse str
    date.strftime("%H:%M:%S")
  end

  def self.get_type
    @doc.xpath("/situation/situationrecord").attribute('xsi:type').value
  end

  def self.get_date
    str = @doc.xpath("/situation/situationrecord/situationrecordcreationtime").text
    date = DateTime.parse str
  end

  def self.get_comment
    string = @doc.xpath("/situation/situationrecord/nongeneralpubliccomment").text.to_s
    reg_string = /^[^\n]*/.match string
    reg_string.to_s
  end

  def self.get_location_name
    RegionFinder.lat_long(self.get_latitude,self.get_longitude)
  end

  def self.get_latitude
    @doc.xpath("/situation/situationrecord/groupoflocations/locationcontainedingroup/tpegpointlocation/
      framedpoint/pointcoordinates/latitude").text
  end

  def self.get_longitude
    @doc.xpath("/situation/situationrecord/groupoflocations/locationcontainedingroup/tpegpointlocation/
      framedpoint/pointcoordinates/longitude").text
  end

  def self.get_traffic_type
    @doc.xpath("/situation/situationrecord/impact/impactontraffic").text
  end

  def self.get_delay_time
    @doc.xpath("/situation/situationrecord/impact/delays").text
  end

  def self.get_capacityRemaining
    @doc.xpath("/situation/situationrecord/impact/impactdetails/capacityremaining").text
  end

  def self.get_trafficRestrictionType
    @doc.xpath("/situation/situationrecord/impact/impactdetails/trafficrestrictiontype").text
  end

  def tester
    xml = Nokogiri::HTML(open("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml"))
    res = xml.xpath("/html/body/d2logicalmodel/payloadpublication/situation/situationrecord/@id")[0]
  end

end
