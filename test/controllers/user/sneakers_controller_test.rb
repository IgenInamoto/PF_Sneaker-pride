require "test_helper"

class User::SneakersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_sneakers_new_url
    assert_response :success
  end

  test "should get index" do
    get user_sneakers_index_url
    assert_response :success
  end

  test "should get show" do
    get user_sneakers_show_url
    assert_response :success
  end
end
