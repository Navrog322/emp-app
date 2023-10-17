require "application_system_test_case"

class EmploymentStatusesTest < ApplicationSystemTestCase
  setup do
    @employment_status = employment_statuses(:one)
  end

  test "visiting the index" do
    visit employment_statuses_url
    assert_selector "h1", text: "Employment statuses"
  end

  test "should create employment status" do
    visit employment_statuses_url
    click_on "New employment status"

    fill_in "Name", with: @employment_status.name
    click_on "Create Employment status"

    assert_text "Employment status was successfully created"
    click_on "Back"
  end

  test "should update Employment status" do
    visit employment_status_url(@employment_status)
    click_on "Edit this employment status", match: :first

    fill_in "Name", with: @employment_status.name
    click_on "Update Employment status"

    assert_text "Employment status was successfully updated"
    click_on "Back"
  end

  test "should destroy Employment status" do
    visit employment_status_url(@employment_status)
    click_on "Delete this employment status", match: :first

    assert_text "Employment status was successfully deleted"
  end
end
