require 'test_helper'

module Csf
  class PagesControllerTest < ActionController::TestCase
    test "should get landing" do
      get :landing
      assert_response :success
    end

  end
end
