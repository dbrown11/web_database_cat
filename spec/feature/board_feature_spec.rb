require "helpers/database_helpers"

RSpec.describe "Cat board Feature", type: :feature do
  before(:each) do
    DatabaseHelpers.clear_table("board_entries")
  end

  it "starts with no lost cat adverts" do
    visit "/board"
    expect(page).to have_content "There are no lost cats :D"
  end

  it "adds a diary entry and shows it in the list " do
    visit "/board"
    click_link "Add entry"
    fill_in "Number", with: "07364543635"
    fill_in "Description", with: "Ginger cat"
    click_button "Add entry"
    expect(page).to have_content "07364543635"
    expect(page).to have_content "Ginger cat"
  end

end