require "helpers/database_helpers"
require "comment_table"
require "comment_entity"


RSpec.describe CommentList do
  def clean_and_get_database 
    DatabaseHelpers.clear_table("comments")
    return DatabaseHelpers.test_db_connection 
  end
  
  it "returns an empty array, if no comments have been added" do
    db = clean_and_get_database
    comment_table = CommentList.new(db)
    expect(comment_table.list).to eq([])
  end

  it "returns a comment" do
    db = clean_and_get_database
    comment_table = CommentList.new(db)
    board_table = BoardTable.new(db, comment_table)

    id_advert = board_table.add(BoardEntryEntity.new("Ginger cat", "07888888888"))
    comment_table.add(CommentEntity.new(
      "Test comment contense",
      id_advert
    ))
    comments=comment_table.list
    expect(comments[0].comment).to eq "Test comment contense"
    expect(comments[0].id_advert).to eq id_advert    
    end
end