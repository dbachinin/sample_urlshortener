require 'test_helper'

class OmniauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  test "should get vkontakte" do
    get omniauth_callbacks_vkontakte_url
    assert_response :success
  end

end
