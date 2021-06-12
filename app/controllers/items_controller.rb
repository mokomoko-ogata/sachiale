class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :show, :edit, :update, :destroy, :search]
  before_action :search_item, only: [:index, :search]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_top, only: [:edit, :update, :destroy]

  def index
    @items = Item.where(user_id: current_user.id).order(open_date: :asc)
    set_item_column
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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

  def search
    @results = @p.result.where(user_id: current_user.id).order(open_date: :asc)
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :memo, :amount, :open_date, :unit_id, :category_id, :meat_id, :vegetable_id,
                                 :seafood_id, :seaweed_id, :mushroom_id, :egg_id, :corm_id, :bread_id, :rice_id, :milk_id, :bean_id, :noodle_id, :seasoning_id).merge(user_id: current_user.id)
  end

  def search_item
    @p = Item.ransack(params[:q])
  end

  def set_item_column
    @item_name = Item.select('item_name').distinct.where(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_top
    redirect_to blogs_path unless current_user.id == @item.user_id
  end
end
