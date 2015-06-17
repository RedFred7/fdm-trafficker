
require_relative 'scraper'

class Validator

  EXPECTED_NODES=['probabilityOfOccurrence' ,
                  'groupOfLocations',
                  'situationRecordVersion',
                  'situationRecordCreationTime'
                  ]
  def self.validate(situation)
    res = false
    EXPECTED_NODES.each do |node|
      res = true if situation.css("#{node}")
    end
    res
  end
end
