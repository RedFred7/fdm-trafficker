# @author Tomos John Rees

require 'net/http'
require 'json'


class RegionFinder
  def self.lat_long(latitude, longitude)
    postcode = postcode_from_lat_long(latitude, longitude)
    european_region_from_postcode(postcode)
  end

  #Returns a european region given a location's postcode.
  def self.european_region_from_postcode(postcode)
    uri = URI("http://mapit.mysociety.org/postcode/#{postcode.gsub(/\s+/, "")}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)["areas"].each do |k,v|
    	return v["name"] if v.has_value?("European region")
    end
  end


  def self.postcode_from_lat_long(latitude, longitude)
    uri = URI("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{latitude},#{longitude}&sensor=false")
    response = Net::HTTP.get(uri)
    JSON.parse(response)["results"][2]['address_components'][0]['long_name']
  end
end

puts RegionFinder.lat_long(52.509106,-1.861836)
# puts RegionFinder.lat_long(51.42615,0.238258)
# puts RegionFinder.lat_long(52.34102,-0.207559)
# puts RegionFinder.postcode_from_lat_long(51.4223, 0.23722)

uri = URI("https://maps.googleapis.com/maps/api/geocode/json?latlng=51.4223,0.23722&sensor=false")
response = Net::HTTP.get(uri)
# p JSON.parse(response)["results"][2]['address_components']


JSON.parse(response)["results"][1].each do |item|
	#puts "************************************************"
	#p item
end