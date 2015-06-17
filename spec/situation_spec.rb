# arr = ParseWebXML.parse("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml")
# #p arr[1]
# s = Situation.initialize(arr[0].to_s)


describe Situation do
  it "ensures data is read from XML file and fed into situation object" do
   arr = ParseWebXML.parse("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml")
      s = Situation.initialize(arr[0].to_s)
      expect(s.to_s).not_to be_empty
    end
 

  # it "ensures identical guid is stored from XML to situation object" do
  #   arr = ParseWebXML.parse("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml")
  #   s = Situation.initialize(arr[0].to_s)
  #   s.guid
  # end

end


