class Public::ComicsController < ApplicationController
  def index
    @categories = Category.all
    @comics = Comic.all
  end

  def show
    @categories = Category.all
    @comic = Comic.find_by(isbn: params[:isbn])
    @reviews = @comic.reviews
    @tag = Tag.new
    @tags = @comic.tags
    @user = User.find_by(id: params[:id], name: params[:name])
  end
end
