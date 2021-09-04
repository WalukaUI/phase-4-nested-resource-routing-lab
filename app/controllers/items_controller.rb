class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
def index
  if params[:user_id]
    user = User.find(params[:user_id])
    items = user.items
  else
    items = Item.all
  end
  render json: items, include: :user
end

def create
  user = User.find(params[:user_id])
  items = user.items.create(itemparams)
  render json: items, status: 201
end


def show
  item = find_item
  render json: item
end

  private

  def find_item
    Item.find(params[:id])
  end
  def itemparams
    params.permit(:name, :description, :price)
  end
  def not_found_response(i)
    render json: { error: "#{i.model} not found" }, status: 404
  end
end
