module Utils  ##module for reading xml
  require 'ohm'
  require 'open-uri'
  require 'nokogiri'
  require 'logger'

  class XML

    def self.read_xml

      #xml = Nokogiri::HTML(open("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml"))

      xml = Nokogiri::XML(File.open("/home/ubuntu/sky_project/fdm-trafficker/spec/data/my_xml.xml"))
      res = xml.xpath("/situation[@id='GUID1-704556338']")
      yield res
    end
  end
end
