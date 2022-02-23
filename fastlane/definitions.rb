require_relative 'base'

# VersionIncrement definitions
class Patch < VersionIncrement
  @@lookup << self
  def self.increment_name
    "patch"
  end
end

class Minor < VersionIncrement
  @@lookup << self
  def self.increment_name
    "minor"
  end
end