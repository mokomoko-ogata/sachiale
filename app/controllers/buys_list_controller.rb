class BuysListController < ApplicationController
  def index
    @buy_list = BuyList.where(user_id: current_user.id)
  end

  def new
    @buy_list = BuyList.new
  end

  def create
    @buy_list = BuyList.new(buy_list_params)
    if @buy_list.save
      redirect_to buys_list_index_path(current_user.id)
    else
      render :new
    end
  end

  def edit
    @buy_list = BuyList.find(params[:id])
  end

  def update
    @buy_list = BuyList.find(params[:id])
    if @buy_list.update(buy_list_params)
      redirect_to buys_list_index_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    @buy_list = BuyList.find(params[:id])
    @buy_list.destroy
    redirect_to buys_list_index_path(current_user.id)
  end

  private

  def buy_list_params
    params.require(:buy_list).permit(:item_name, :buy_memo, :amount, :unit_id).merge(user_id: current_user.id)
  end
end
