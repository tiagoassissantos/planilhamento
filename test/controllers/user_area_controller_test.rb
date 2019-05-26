require 'test_helper'

class UserAreaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_area_index_url
    assert_response :success
  end

end
