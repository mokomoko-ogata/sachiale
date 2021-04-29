class ItemsController < ApplicationController
  def index
    
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path(current_user.id)
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :memo, :amount, :open_date, :unit_id, :category_id, :meat_id, :vegetable_id, :seafood_id, :seaweed_id, :mushroom_id, :egg_id, :corm_id, :bread_id, :rice_id, :milk_id, :bean_id, :noodle_id, :seasoning_id).merge(user_id: current_user.id)
  end
end
