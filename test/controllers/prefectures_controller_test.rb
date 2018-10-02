require 'test_helper'

class PrefecturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prefecture = prefectures(:one)
  end

  test "should get index" do
    get prefectures_url
    assert_response :success
  end

  test "should get new" do
    get new_prefecture_url
    assert_response :success
  end

  test "should create prefecture" do
    assert_difference('Prefecture.count') do
      post prefectures_url, params: { prefecture: { name: @prefecture.name } }
    end

    assert_redirected_to prefecture_url(Prefecture.last)
  end

  test "should show prefecture" do
    get prefecture_url(@prefecture)
    assert_response :success
  end

  test "should get edit" do
    get edit_prefecture_url(@prefecture)
    assert_response :success
  end

  test "should update prefecture" do
    patch prefecture_url(@prefecture), params: { prefecture: { name: @prefecture.name } }
    assert_redirected_to prefecture_url(@prefecture)
  end

  test "should destroy prefecture" do
    assert_difference('Prefecture.count', -1) do
      delete prefecture_url(@prefecture)
    end

    assert_redirected_to prefectures_url
  end
end
