require 'test_helper'

class GetCompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get get_from_api" do
    get get_companies_get_from_api_url
    assert_response :success
  end

end
