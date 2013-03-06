require 'dolarblue/version'
require 'dolarblue/configuration'
require 'dolarblue/class_methods'
require 'dolarblue/instance_methods'
require 'dolarblue/exchange'

# Main class used as builder and also as Dolarblue namespace
class Dolarblue
  extend ClassMethods
  include InstanceMethods
end
