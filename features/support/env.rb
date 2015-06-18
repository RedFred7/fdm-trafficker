require 'rake'

load File.join(File.dirname(__FILE__), '../..', 'Rakefile')
#set up Redis data needed for all Cucumber features
Rake::Task['test:seed_redis'].invoke
Rake::Task['test:seed_redis_with_one_object'].invoke


at_exit do
  # clear Redis data before Cucumber exits
  Rake::Task['test:clear_redis'].invoke
end
