class BlogsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @blogs = Blog.order('created_at DESC')  
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

  private

  def blog_params
    params.require(:blog).permit(:image, :recipe_name, :explain, :price).merge(user_id: current_user.id)
  end
end
