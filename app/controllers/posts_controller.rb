class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.build
  end  
  
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @posts = current_user.posts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
