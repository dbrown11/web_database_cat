class BoardEntryEntity
  def initialize(number, description)
    @number = number
    @description = description
  end

  def number
    return @number
  end

  def description
    return @description
  end
end