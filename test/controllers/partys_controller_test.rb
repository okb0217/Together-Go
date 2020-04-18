require 'test_helper'

class PartysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get partys_index_url
    assert_response :success
  end

  test "should get show" do
    get partys_show_url
    assert_response :success
  end

  test "should get new" do
    get partys_new_url
    assert_response :success
  end

  test "should get edit" do
    get partys_edit_url
    assert_response :success
  end

end
