require "helpers/database_helpers"
require "board_entry_entity"
require "board_table"

RSpec.describe BoardTable do
  def clean_and_get_database
    DatabaseHelpers.clear_table("board_entries")
    return DatabaseHelpers.test_db_connection
  end

  it "start with an empty table" do
    db = clean_and_get_database
    board_table = BoardTable.new(db)
    expect(board_table.list).to eq([])
  end

  it "adds entry and lists them out again" do
    db = clean_and_get_database
    board_table = BoardTable.new(db)
    board_entry = BoardEntryEntity.new("07982632652", "Ginger cat")
    board_table.add(board_entry)

    board_entries = board_table.list
    expect(board_entries.length).to eq 1
    expect(board_entries[0].number).to eq "07982632652"
    expect(board_entries[0].description).to eq "Ginger cat"
  end

end