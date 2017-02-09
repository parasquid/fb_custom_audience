require 'test_helper'

class DataSource::AdAccounts::CustomAudiencesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get data_source_ad_accounts_custom_audiences_index_url
    assert_response :success
  end

end
