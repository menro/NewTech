require 'test_helper'

class CompanyDecoratorTest < ActiveSupport::TestCase
  def setup
    ApplicationController.new.view_context
  end
end
