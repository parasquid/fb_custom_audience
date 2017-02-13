require 'test_helper'

class AdAccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ad_accounts_index_url
    assert_response :success
  end

  test "should get show" do
    get ad_accounts_show_url
    assert_response :success
  end

end
