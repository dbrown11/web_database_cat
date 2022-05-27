class CommentEntity
  def initialize(comment, id_advert, id_comment = nil)
    @comment = comment
    @id_advert = id_advert
    @id_comment = id_comment
  end

  def comment
    return @comment
  end
  
  def id_advert
    return @id_advert
  end

  def id_comment
    return @id_comment
  end

end
