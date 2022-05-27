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

  it "adds mutiple Diary entries" do
    visit "/board"
    click_link "Add entry"
    fill_in "Number", with: "07364543600"
    fill_in "Description", with: "Ginger cat"
    click_button "Add entry"
    click_link "Add entry"
    fill_in "Number", with: "07364543611"
    fill_in "Description", with: "Black cat"
    click_button "Add entry"
    click_link "Add entry"
    fill_in "Number", with: "07364543622"
    fill_in "Description", with: "White cat"
    click_button "Add entry"
    expect(page).to have_content "07364543600"
    expect(page).to have_content "Ginger cat"
    expect(page).to have_content "07364543611"
    expect(page).to have_content "Black cat"
    expect(page).to have_content "07364543622"
    expect(page).to have_content "White cat"
  end

  it "adds mutiple entries and removes an entry" do
    visit "/board"
    click_link "Add entry"
    fill_in "Number", with: "07364543600"
    fill_in "Description", with: "Ginger cat"
    click_button "Add entry"
    click_link "Add entry"
    fill_in "Number", with: "07364543611"
    fill_in "Description", with: "Black cat"
    click_button "Add entry"
    click_link "Add entry"
    fill_in "Number", with: "07364543622"
    fill_in "Description", with: "White cat"
    click_button "Add entry"
    
    click_button "delete_07364543611"

    expect(page).to have_content "07364543600"
    expect(page).to have_content "Ginger cat"
    expect(page).not_to have_content "07364543611"
    expect(page).not_to have_content "Black cat"
    expect(page).to have_content "07364543622"
    expect(page).to have_content "White cat"
  end

  it "adds mutiple entries and eddit one" do
    visit "/board"
    click_link "Add entry"
    fill_in "Number", with: "07364543600"
    fill_in "Description", with: "Ginger cat"
    click_button "Add entry"
    click_link "Add entry"
    fill_in "Number", with: "07364543611"
    fill_in "Description", with: "Black cat"
    click_button "Add entry"
    click_link "Add entry"
    fill_in "Number", with: "07364543622"
    fill_in "Description", with: "White cat"
    click_button "Add entry"

    click_link "edit_board_07364543611"
    fill_in "number", with: "07364543633"
    fill_in "description", with: "Blue cat"
    click_button "Update entry"

    expect(page).to have_content "07364543600"
    expect(page).to have_content "Ginger cat"
    expect(page).not_to have_content "07364543611"
    expect(page).not_to have_content "Black cat"
    expect(page).to have_content "07364543633"
    expect(page).to have_content "Blue cat"
    expect(page).to have_content "07364543622"
    expect(page).to have_content "White cat"

  end

  

end