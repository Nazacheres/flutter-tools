# Base file containing all definitions
# Definition of VersionIncrement
class VersionIncrement
  @@lookup = []

  def self.get(name)
    @@lookup.each { |item|
        if item.increment_name == name
            return item
        end
    }

    return nil
  end

  def self.as_list
    @@lookup.map { |item|
        item.increment_name
    }
  end
end