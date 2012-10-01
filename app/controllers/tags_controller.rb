class TagsController < ApplicationController
  respond_to :json

  def index
    @tags = TagService::search(params)
  end
end
