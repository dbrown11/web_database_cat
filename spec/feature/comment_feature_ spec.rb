require "helpers/database_helpers"

RSpec.describe "Comment board features", type: :feature do
  before(:each) do
    DatabaseHelper.clear_table("board_entries")
    DatabaseHelper.clear_table("comments")
  end

  it "adds comments and displays them on the entries" do
    vist "/board"
    
    click_link "Add entry"
    fill_in "Number", with: "07364543600"
    fill_in "Description", with: "Ginger cat"
    click_button "Add entry"
    
    click_link "Add new comment"

    fill_in "comment", with: "TGIF!"
    click_button "Add comment"
    
    expect(page).to have_content "TGIF!"
  end
  
end

