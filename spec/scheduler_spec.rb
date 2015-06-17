describe ParseWebXML do
  before :all do
    @arr = ParseWebXML.parse("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml")
  end

  it "should return an array" do
    expect(@arr).to be_kind_of(Array)
  end

  it "should return node object with 12 elements" do
    (0..@arr.length-1).each do |num|
      count = 0
      @arr[num].children[1].children.each { count += 1 }
      expect(count).to eq(12)
    end
  end
end

#TODO: put log
describe Scheduler do
  before :all do
    @arr = ParseWebXML.parse("http://hatrafficinfo.dft.gov.uk/feeds/datex/England/UnplannedEvent/content.xml")
    #Scheduler.start 
  end

  it "creates an object of type situation when passed a valid url" do
    
  end

  it "logs when the situation is created" do

  end

  it "logs when the job is reschedueled" do

  end
end
