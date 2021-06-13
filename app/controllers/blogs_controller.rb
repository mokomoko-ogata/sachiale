class BlogsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :change]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :search_blog, only: [:index, :search, :change]

  def index
    @blogs = Blog.order('created_at DESC').page(params[:page]).per(2)
    set_blog_column
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comments = Comment.where(blog_id: @blog.id)
    @comment = Comment.new
    @current_blog = Blog.find(@blog.id)
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blog_path(@blog.id)
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to root_path
  end

  def search
    @results = @p.result
  end

  def change
    @item_blogs = Blog.joins(:items).where(user_id: current_user.id).distinct.page(params[:page]).per(2)
    set_blog_column
  end

  private

  def blog_params
    params.require(:blog).permit(:image, :recipe_name, :explain, :price, { item_ids: [] }).merge(user_id: current_user.id)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless current_user.id == @blog.user_id
  end

  def search_blog
    @p = Blog.ransack(params[:q])
  end

  def set_blog_column
    @blog_name = Blog.select('recipe_name').distinct
  end
end
