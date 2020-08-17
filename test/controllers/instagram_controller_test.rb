require 'test_helper'

class InstagramControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get instagram_new_url
    assert_response :success
  end

end
