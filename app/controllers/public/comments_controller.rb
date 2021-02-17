class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.find(params[:review_id])
    comment = current_user.comments.new(comment_params)
    comment.review_id = @review.id
    comment.save
    # redirect_back(fallback_location: root_path)
    # render :index
    @comment = Comment.new
  end

  def destroy
    @comment = Comment.find(params[:id])
    @review = Review.find(params[:review_id])
    Comment.find_by(id: params[:id], review_id: params[:review_id]).destroy
    # redirect_back(fallback_location: root_path)
    # render :index
    @comment = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(:review_id, :comment)
  end
end
