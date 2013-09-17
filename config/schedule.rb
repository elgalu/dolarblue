# set :output, "/path/to/my/cron_log.log"

require 'pry'
pry.bindings
puts 5.minutes.inspect
puts 5.days.inspect
puts 5.years.inspect

every 5.minutes do
  command "dolarblue"
end

# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
