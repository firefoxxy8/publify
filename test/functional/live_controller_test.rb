require File.dirname(__FILE__) + '/../test_helper'
require 'live_controller'

#
# Re-raise errors caught by the controller.
class LiveController; def rescue_action(e) raise e end; end

class LiveControllerTest < Test::Unit::TestCase
  fixtures :contents, :blogs

  def setup
    @controller = LiveController.new
    @request, @response = ActionController::TestRequest.new, ActionController::TestResponse.new
  end

  def test_search
    get :search, :q => "search target"
    assert_equal 1, assigns(:articles).size
    get :search, :q => "second blog article"
    assert_equal 0, assigns(:articles).size
  end

end

