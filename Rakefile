require_relative 'lib/situation'

namespace :test do
  desc 'Seed Redis with situation objects'
  task :seed_redis do

    10.times do |i|
      Situation.create(guid: "HSGADS#{i}8#{i+3}GHS",
                       version: i.odd? ? "#{i+1}".to_i : "#{i}".to_i,
                       time: Time.now + (360 * (24 * i)),
                       type: i.odd? ? 'accident' : 'obstruction',
                       delay_time: 1200 + ((i*2) ** 2))
    end

  end

  task :seed_redis_for_aggregation do
    20.times do |i|
      Situation.create(guid: "HSGADS#{i}8#{i+3}GHS",
                       version: i.odd? ? "#{i+1}".to_i : "#{i}".to_i,
                       time: Time.now + (360 * (24 * i)),
                       type: i.odd? ? 'accident' : 'obstruction',
                       delay_time: 1200 + ((i*2) ** 2),
                       location_name: 'London')
    end
  end



  desc 'Clear Redis of situation objects'
  task :clear_redis do
    Ohm.redis.call "FLUSHDB"
  end
end
