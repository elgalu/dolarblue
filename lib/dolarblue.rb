require 'dolarblue/version'
require 'dolarblue/configuration'
require 'dolarblue/class_methods'
# require 'dolarblue/instance_methods'
# require 'dolarblue/exchange'

# Daemon does:
every Config.instance.poll_every do
  dollar = Dolarblue.new
  dollar.update!
  dollar.inform_if_updates
end

dollar.blue.buy_value #=> 8.60
dollar.blue.sell_value #=> 8.90
dollar.card.sell_value #=> ....

# Main class used as builder and also as Dolarblue namespace
class Dolarblue
  extend ClassMethods


end
