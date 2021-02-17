class Public::HomesController < ApplicationController
  def top
    @categories = Category.all
    @random = Comic.order('RANDOM()').limit(15)
    @revdom = Review.order('RANDOM()').limit(5)
  end

  def about
    @categories = Category.all
  end

  def search
    @categories = Category.all
    @category = Category.find(params[:id])
    @comics = @category.comics
    @comic = Comic.find_by(isbn: params[:isbn])
  end
end
