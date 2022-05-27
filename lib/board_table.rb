require "board_entry_entity"

class BoardTable 
  def initialize(db, comment_table)
    @db = db
    @comment_table = comment_table
  end

  def list
    return @db.run("SELECT * FROM board_entries ORDER BY id;").map do |row|
      row_to_object(row)
    end
  end

  def add(entry)
    result = @db.run(
      "INSERT INTO board_entries (number, description) VALUES ($1, $2) RETURNING id;",
      [entry.number, entry.description]
    )
    return result[0]["id"]
  end
  
  def remove(index)
    @db.run("DELETE FROM board_entries WHERE id = $1 ;", [index])
  end

  def get(index)
    result = @db.run("SELECT * FROM board_entries WHERE id = $1;", [index])
    return row_to_object(result[0])
  end

  
  def update(index, number, description)
    @db.run("UPDATE board_entries SET (number, description) = ($1, $2) WHERE id = $3;", [number, description , index])
  end


  private

  def row_to_object(row)
    return BoardEntryEntity.new(
      row["number"],
      row["description"],
      row["id"]
    )
  end



end