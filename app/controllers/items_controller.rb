class ItemsController < ApplicationController
  def index
    @item = Item.where(user_id: current_user.id).order(open_date: :asc)
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

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :memo, :amount, :open_date, :unit_id, :category_id, :meat_id, :vegetable_id,
                                 :seafood_id, :seaweed_id, :mushroom_id, :egg_id, :corm_id, :bread_id, :rice_id, :milk_id, :bean_id, :noodle_id, :seasoning_id).merge(user_id: current_user.id)
  end
end
