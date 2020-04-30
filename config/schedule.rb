# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
rails_env = ENV['RAILS_ENV'] || :development
if rails_env == :development
  path =  "/Users/shumpei.ueda/RubymineProjects/Companydb"
else
  path = "/var/www/rails/companydb"
end

set :environment, rails_env
set :output, 'log/cron.log'
set :path, path



every 1.minutes do
  rake "company:get_companies_from_api"
end


every 10.minutes do
  rake "reflect_db:reflect_from_yahoo_data"
end


