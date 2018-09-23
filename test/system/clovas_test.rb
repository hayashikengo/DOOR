require "application_system_test_case"

class ClovasTest < ApplicationSystemTestCase
  setup do
    @clova = clovas(:one)
  end

  test "visiting the index" do
    visit clovas_url
    assert_selector "h1", text: "Clovas"
  end

  test "creating a Clova" do
    visit clovas_url
    click_on "New Clova"

    fill_in "Name", with: @clova.name
    click_on "Create Clova"

    assert_text "Clova was successfully created"
    click_on "Back"
  end

  test "updating a Clova" do
    visit clovas_url
    click_on "Edit", match: :first

    fill_in "Name", with: @clova.name
    click_on "Update Clova"

    assert_text "Clova was successfully updated"
    click_on "Back"
  end

  test "destroying a Clova" do
    visit clovas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Clova was successfully destroyed"
  end
end
