require 'test_helper'

class ClovasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @clova = clovas(:one)
  end

  test "should get index" do
    get clovas_url
    assert_response :success
  end

  test "should get new" do
    get new_clova_url
    assert_response :success
  end

  test "should create clova" do
    assert_difference('Clova.count') do
      post clovas_url, params: { clova: { name: @clova.name } }
    end

    assert_redirected_to clova_url(Clova.last)
  end

  test "should show clova" do
    get clova_url(@clova)
    assert_response :success
  end

  test "should get edit" do
    get edit_clova_url(@clova)
    assert_response :success
  end

  test "should update clova" do
    patch clova_url(@clova), params: { clova: { name: @clova.name } }
    assert_redirected_to clova_url(@clova)
  end

  test "should destroy clova" do
    assert_difference('Clova.count', -1) do
      delete clova_url(@clova)
    end

    assert_redirected_to clovas_url
  end
end
