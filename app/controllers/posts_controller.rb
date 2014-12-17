class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show]

  def index
    if current_user.author?
      @posts = Post.all
    else
      @posts = Post.where(published: true)
    end
  end

  def show
  end

  def create
    @post = Post.new(post_params)
    if @post.save!
      flash[:success] = "Post published!"
      redirect_to posts_path
    else
      flash[:error] = "There was an error publishing your post."
    end
  end

  def edit
    redirect_to :root unless current_user.author?
  end

  def new
    @post = Post.new
  end

  private
  def set_post
    @post = params['post']
  end

  def post_params
    params.require(:post).permit(:title, :body, :author, :publish_date, :editors, :published)
  end
end
