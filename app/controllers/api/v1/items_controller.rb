class Api::V1::ItemsController < Api::V1::ApplicationController

  def index
    @items = Item.all
    respond_with @items
  end
end
