class AggregateFunction
  attr_reader :situation_set

  def average_where(location)
    sum = 0.000
    @situation_set = Situation.find(location_name: location)
    @situation_set.each do |item|
      sum +=  item.delay_time.to_i
    end

    @situation_set.size == 0 ? 0.00 : sum/@situation_set.size

  end

end
