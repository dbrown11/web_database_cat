class BoardEntryEntity
  def initialize(number, description, id = nil)
    @number = number
    @description = description
    @id = id
    @sighting = []
  end

  def number
    return @number
  end

  def description
    return @description
  end

  def id
    return @id
  end

  def add_sighting(input)
    @sighting << input
  end

  def sighting
    all_sightings = ""
    @sighting.each do |item| 
      all_sightings += item +"\n"

    end
    return all_sightings
  end

end