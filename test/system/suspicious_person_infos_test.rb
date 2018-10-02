require "application_system_test_case"

class SuspiciousPersonInfosTest < ApplicationSystemTestCase
  setup do
    @suspicious_person_info = suspicious_person_infos(:one)
  end

  test "visiting the index" do
    visit suspicious_person_infos_url
    assert_selector "h1", text: "Suspicious Person Infos"
  end

  test "creating a Suspicious person info" do
    visit suspicious_person_infos_url
    click_on "New Suspicious Person Info"

    fill_in "City", with: @suspicious_person_info.city_id
    fill_in "Published At", with: @suspicious_person_info.published_at
    fill_in "Text", with: @suspicious_person_info.text
    click_on "Create Suspicious person info"

    assert_text "Suspicious person info was successfully created"
    click_on "Back"
  end

  test "updating a Suspicious person info" do
    visit suspicious_person_infos_url
    click_on "Edit", match: :first

    fill_in "City", with: @suspicious_person_info.city_id
    fill_in "Published At", with: @suspicious_person_info.published_at
    fill_in "Text", with: @suspicious_person_info.text
    click_on "Update Suspicious person info"

    assert_text "Suspicious person info was successfully updated"
    click_on "Back"
  end

  test "destroying a Suspicious person info" do
    visit suspicious_person_infos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Suspicious person info was successfully destroyed"
  end
end
