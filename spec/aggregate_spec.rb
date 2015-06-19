describe AggregateFunction do
  # Create some mock data to query on
  before :all do
    `rake test:seed_redis_for_aggregation`
  end

  it "should accept a string and should return a float number" do
    query = AggregateFunction.new
    expect(query.average_where('aString')).to be_kind_of(Float)
  end

  it "should find 4 entries within London" do
  	query = AggregateFunction.new
  	query.average_where('London')
  	expect(query.situation_set.size).to eq(20)
  end

  it "should return 0 for an unkown locaton" do 
  	query = AggregateFunction.new
  	expect(query.average_where('Faafaf')).to eq(0)
  end

  # delete the data created before the tests
  after :all do
    `rake test:clear_redis`
  end

end
