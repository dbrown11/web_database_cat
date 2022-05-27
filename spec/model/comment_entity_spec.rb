require "comment_entity"

RSpec.describe CommentEntity do
  it "constructs" do
    comment_1 = CommentEntity.new(
      "I found the cat",
      1,
      2
    )
    expect(comment_1.comment).to eq "I found the cat"
    expect(comment_1.id_advert).to eq 1
    expect(comment_1.id_comment).to eq 2
  end

  
end