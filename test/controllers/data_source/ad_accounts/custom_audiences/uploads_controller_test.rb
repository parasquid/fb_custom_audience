require 'test_helper'

class DataSource::AdAccounts::CustomAudiences::UploadsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get data_source_ad_accounts_custom_audiences_uploads_create_url
    assert_response :success
  end

end
