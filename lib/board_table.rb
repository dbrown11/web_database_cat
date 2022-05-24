require "board_entry_entity"

class BoardTable 
  def initialize(db)
    @db = db
  end

  def add(entry)
    @db.run(
      "INSERT INTO board_entries (number, description) VALUES ($1, $2) RETURNING id;",
      [entry.number, entry.description]
    )
  end

  def list
    return @db.run("SELECT * FROM board_entries ORDER BY id;").map do |row|
      row_to_object(row)
    end
  end

  private

  def row_to_object(row)
    return BoardEntryEntity.new(
      row["number"],
      row["description"]
    )
  end



end