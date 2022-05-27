class CommentList
  def initialize(db)
    @db = db

  end

  def list
    return @db.run("SELECT * FROM comments ORDER BY id_comment").map do |row|
      row_to_object(row)
    end
  end

  def add(comment)
    result = @db.run(
      "INSERT INTO comments (comment, id_advert) VALUES ($1, $2) RETURNING id_advert",
      [comment.comment, comment.id_advert])
    return result[0]["id_advert"]
  end

  def row_to_object(row)
    return CommentEntity.new(
      row["comment"],
      row["id_advert"],
      row["id_comment"]
    )
  end

end