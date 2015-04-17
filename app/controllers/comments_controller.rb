class CommentsController < ApplicationController

  def create
    @discussion = Discussion.find params[:discussion_id]
    @comment = Comment.new comment_params
    @comment.discussion = @discussion
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_discussion_path(@discussion.post, @discussion) }
        format.js   { render :create_success }
      else
        format.html { render "discussions/show" }
        format.js   { render :create_failure }
      end
    end
  end

  def destroy
    # @discussion = Discussion.find params[:discussion_id]
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to post_discussion_path(@comment.post, @comment.discussion)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
