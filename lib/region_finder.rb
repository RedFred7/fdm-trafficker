# @author Tomos John Rees
require 'net/http'
require 'json'
require 'open-uri'
require_relative 'logger'

class RegionFinder
  #Finds the region where the point based on it's latitude and longitude is located.
  # @param one [Fixnum] Latitude of the point of interest.
  # @param two [Fixnum] Longitude of the point of interest.
  # @return [String] Region the point of interest is located within.
  def self.lat_long(latitude, longitude)
    postcode = postcode_from_lat_long(latitude, longitude)
    if postcode
      european_region_from_postcode(postcode)
    else
      #TODO: need logger here
    end
  end

  #Finds a european region given a location's postcode.
  # @param one [String] Postcode of the location.
  # @return [String] Region the postcode is contained within.
  def self.european_region_from_postcode(postcode)
    uri = URI("http://mapit.mysociety.org/postcode/#{postcode.gsub(/\s+/, "")}")
    response = Net::HTTP.get(uri)
    hash = JSON.parse(response)["areas"]
    if hash
      JSON.parse(response)["areas"].each do |k,v|
        return v["name"] if v.has_value?("European region")
      end
    else
      Logger.log.error("class = #{self.name}, method=#{ __method__}, postcode = #{postcode}")
      return
    end
  end

  #Finds the postcode closest to point based on it's latitude and longitude.
  # @param one [Fixnum] Latitude of the point of interest.
  # @param two [Fixnum] Longitude of the point of interest.
  # @return [String] Postcode nearest to the point of interest.
  def self.postcode_from_lat_long(latitude, longitude)
    begin
      forwarded_uri = open("http://uk-postcodes.com/latlng/#{latitude},#{longitude}.json").base_uri
      response = Net::HTTP.get(forwarded_uri)
      JSON.parse(response)["postcode"]
    rescue OpenURI::HTTPError => e
      Logger.log.error("#{e}, class=#{self.name}, method=#{ __method__}, latitude=#{latitude}, longitude=#{longitude}")
      return
    end
  end
end
