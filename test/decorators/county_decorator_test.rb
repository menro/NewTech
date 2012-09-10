require 'test_helper'

class CountyDecoratorTest < ActiveSupport::TestCase
  def setup
    ApplicationController.new.view_context
  end
end
