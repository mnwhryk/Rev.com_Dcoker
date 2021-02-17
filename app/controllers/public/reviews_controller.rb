class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @categories = Category.all
    @review = Review.new
    @comic = Comic.find_by(isbn: params[:comic_id])
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to comic_path(@review.comic.isbn), notice: 'レビューを追加しました'
    else
      @comic = Comic.find_by(isbn: params[:comic_id])
      render :new
    end
  end

  def index
    @categories = Category.all
    @reviews = @comic.reviews
  end

  def show
    @categories = Category.all
    @review = Review.find(params[:id])
    @comic = Comic.find_by(isbn: params[:comic_id])
    @comment = Comment.new
  end

  def edit
    @categories = Category.all
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to comic_review_path(@review.id), notice: '更新しました'
    else
      @categories = Category.all
      render :edit
    end
  end

  def destroy
    @categories = Category.all
    @review = Review.find(params[:id])
    @comic = Comic.find_by(isbn: params[:comic_id])
    @review.destroy
    redirect_to comic_path(@comic.isbn), notice: 'レビューを削除しました'
  end

  private

  def review_params
    params.require(:review).permit(:comic_id, :user_id, :review, :rate)
  end
end
