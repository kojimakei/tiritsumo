class TagsController < ApplicationController
  def index
    @tag_lists = Tag.all
  end
end
