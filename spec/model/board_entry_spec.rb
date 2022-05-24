require "board_entry_entity"

RSpec.describe "Board entry" do
  it "Constructs with a number and description" do
    board_entry = BoardEntryEntity.new("07982726666", "Ginger cat")
    expect(board_entry.number).to eq "07982726666"
    expect(board_entry.description).to eq "Ginger cat"
  end
end