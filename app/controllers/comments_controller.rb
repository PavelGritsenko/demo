class CommentsController < ApplicationController
  before_action :set_post

  # def create
  #   @comment = @post.comments.create(comment_params.merge(user_id: current_user.id))
  #   if @comment.errors.any?
  #     redirect_to @post
  #   else
  #     render "posts/show"
  #   end
  # end  

  def create
    @comment = @post.comments.create(comment_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render "posts/show", status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
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
