require 'test_helper'

class SuspiciousPersonInfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @suspicious_person_info = suspicious_person_infos(:one)
  end

  test "should get index" do
    get suspicious_person_infos_url
    assert_response :success
  end

  test "should get new" do
    get new_suspicious_person_info_url
    assert_response :success
  end

  test "should create suspicious_person_info" do
    assert_difference('SuspiciousPersonInfo.count') do
      post suspicious_person_infos_url, params: { suspicious_person_info: { city_id: @suspicious_person_info.city_id, published_at: @suspicious_person_info.published_at, text: @suspicious_person_info.text } }
    end

    assert_redirected_to suspicious_person_info_url(SuspiciousPersonInfo.last)
  end

  test "should show suspicious_person_info" do
    get suspicious_person_info_url(@suspicious_person_info)
    assert_response :success
  end

  test "should get edit" do
    get edit_suspicious_person_info_url(@suspicious_person_info)
    assert_response :success
  end

  test "should update suspicious_person_info" do
    patch suspicious_person_info_url(@suspicious_person_info), params: { suspicious_person_info: { city_id: @suspicious_person_info.city_id, published_at: @suspicious_person_info.published_at, text: @suspicious_person_info.text } }
    assert_redirected_to suspicious_person_info_url(@suspicious_person_info)
  end

  test "should destroy suspicious_person_info" do
    assert_difference('SuspiciousPersonInfo.count', -1) do
      delete suspicious_person_info_url(@suspicious_person_info)
    end

    assert_redirected_to suspicious_person_infos_url
  end
end
