
  require 'open-uri'
  require 'nokogiri'

describe Situation do
  it "ensures data is read from XML file and fed into situation object" do
   arr = ParseWebXML.parse("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml")
      s = Situation.initialize(arr[0].to_s)
      expect(s.to_s).not_to be_empty
    end
 

  it "ensures identical guid is stored from XML to situation object" do
    arr = ParseWebXML.parse("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml")
    s = Situation.initialize(arr[0].to_s)
 		 xml = Nokogiri::HTML(open("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml"))
    res = xml.xpath("/html/body/d2logicalmodel/payloadpublication/situation/@id")[0]
    expect(res.text).to eq(s.guid)
  end

it "ensures identical date is stored from XML to situation object" do
    arr = ParseWebXML.parse("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml")
    s = Situation.initialize(arr[0].to_s)
 		xml = Nokogiri::HTML(open("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml"))
    res = xml.xpath("/html/body/d2logicalmodel/payloadpublication/situation/situationrecord/situationrecordcreationtime")[0]
    date = DateTime.parse res 
    expect(date).to eq(s.date)
  end

  it "ensures identical latitude is stored from XML to situation object" do
    arr = ParseWebXML.parse("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml")
    s = Situation.initialize(arr[0].to_s)
 		xml = Nokogiri::HTML(open("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml"))
    res = xml.xpath("/html/body/d2logicalmodel/payloadpublication/situation/situationrecord/
    	groupoflocations/locationcontainedingroup/tpegpointlocation/
      framedpoint/pointcoordinates/latitude")[0].text
    expect(res).to eq(s.latitude)
  end

  it "ensures identical longitude is stored from XML to situation object" do
    arr = ParseWebXML.parse("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml")
    s = Situation.initialize(arr[0].to_s)
 		xml = Nokogiri::HTML(open("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml"))
     res = xml.xpath("/html/body/d2logicalmodel/payloadpublication/situation/situationrecord/
    	groupoflocations/locationcontainedingroup/tpegpointlocation/
      framedpoint/pointcoordinates/longitude")[0].text
			expect(res).to eq(s.longitude)
  end

end


