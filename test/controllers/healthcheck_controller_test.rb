require 'test_helper'

class HealthcheckControllerTest < ActionController::TestCase
  test 'should respond ok' do
    get :alive
    assert_response :success
  end
end
