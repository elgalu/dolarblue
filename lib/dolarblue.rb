require 'dolarblue/version'
require 'dolarblue/configuration'
require 'dolarblue/class_methods'
require 'dolarblue/instance_methods'
require 'dolarblue/exchange'

class Dolarblue
  extend ClassMethods
  include InstanceMethods
end
