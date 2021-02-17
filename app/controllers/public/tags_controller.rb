class Public::TagsController < ApplicationController
  before_action :authenticate_user!, except: [:search]

  def create
    @comic = Comic.find_by(isbn: params[:comic_id])
    @tag = current_user.tags.new(tag_params)
    @tag.comic_id = @comic.isbn
    # tag_list = params[:tag_name].split("/")
    if @tag.save
      # @tag.save_tag(tag_list)
      redirect_to comic_path(isbn: @comic.isbn)
    else
      render 'public/comics/show'
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @comic = Comic.find_by(isbn: params[:comic_id])
    if @tag.destroy
      [:flash[:notice] = '']
      redirect_to comic_path(isbn: @comic.isbn)
    end
  end

  def search
    @categories = Category.all
    @tag = Tag.find_by(tag_name: params[:tag_name])
    @comics = Comic.joins(:tags).where(tags: { tag_name: @tag.tag_name.to_s })
    # @search_params = tag_name_params
    # @comics = Comic.search(@search_params).include(:tag_name)
  end

  # def tag_name_params
  #   params.fetch(:search,{}).permit(:tag_name)
  # end

  private

  def tag_params
    params.require(:tag).permit(:comic_id, :user_id, :tag_name)
  end
end
