class CommentsController < ApplicationController
  before_action :set_post

  def create
    @post.comments.create comment_params
    redirect_to @post
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to @post, status: :see_other
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
