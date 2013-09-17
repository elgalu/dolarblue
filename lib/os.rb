require 'rbconfig'

class OS
  class << self
    def windows?
      !!(RbConfig::CONFIG["host_os"] =~ /msdos|mswin|win32|djgpp|cygwin|mingw|windows/i)
    end
    def osx?
      !!(RbConfig::CONFIG["host_os"] =~ /darwin/i)
    end
    def linux?
      !!(!windows? && !osx?)
    end
  end
end
