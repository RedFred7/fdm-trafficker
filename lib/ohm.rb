require 'ohm'
require 'open-uri'
require 'nokogiri'

class Situation < Ohm::Model
  attribute :id
  unique :id
  attribute :version
  attribute :time
  attribute :date
  attribute :comment
  attribute :location_name
  attribute :location_coordinates
  attribute :traffic_type
  attribute :delay_time
  attribute :capacityRemaining
  attribute :trafficRestrictionType
end





# @arr = []

# def recent_cds(xml_doc)
#   doc = Nokogiri::HTML(open(xml_doc))
#   res = doc.xpath("//validity").each do |x|
#  # 	/d2LogicalModel/payloadPublication/situation[1]/situationRecord/validity
#     #year = x.content.to_i
#     p x.text
#     #if year >1987
#      #p x.child.xpath("//validityStatus").text
#       #@arr << x.xpath("//confidentiality").text
#     #end
#   end
#   p res
# end

# recent_cds("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml")
# #p @arr
