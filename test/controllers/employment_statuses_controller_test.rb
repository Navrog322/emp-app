require "test_helper"

class EmploymentStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employment_status = employment_statuses(:one)
  end

  test "should get index" do
    get employment_statuses_url
    assert_response :success
  end

  test "should get new" do
    get new_employment_status_url
    assert_response :success
  end

  test "should create employment_status" do
    assert_difference("EmploymentStatus.count") do
      post employment_statuses_url, params: { employment_status: { name: @employment_status.name } }
    end

    assert_redirected_to employment_status_url(EmploymentStatus.last)
  end

  test "should show employment_status" do
    get employment_status_url(@employment_status)
    assert_response :success
  end

  test "should get edit" do
    get edit_employment_status_url(@employment_status)
    assert_response :success
  end

  test "should update employment_status" do
    patch employment_status_url(@employment_status), params: { employment_status: { name: @employment_status.name } }
    assert_redirected_to employment_status_url(@employment_status)
  end

  test "should destroy employment_status" do
    assert_difference("EmploymentStatus.count", -1) do
      delete employment_status_url(@employment_status)
    end

    assert_redirected_to employment_statuses_url
  end
end
