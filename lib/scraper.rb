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