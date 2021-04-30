class BuysListController < ApplicationController
  def index
    
  end

  def new
    @buy_list = BuyList.new
  end

  def create
    @buy_list = BuyList.new(buy_list_params)
    if @buy_list.save
      redirect_to buy_lists_path(current_user.id)
    else
      render :new
    end
  end

  private

  def buy_list_params
    params.require(:buy_list).permit(:item_name, :memo, :amount, :unit_id).merge(user_id: current_user.id)
  end
end
