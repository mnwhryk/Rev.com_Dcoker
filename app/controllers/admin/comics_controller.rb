class Admin::ComicsController < ApplicationController
  before_action :authenticate_admin!

  def search
    @categories = Category.all
    # からの配列を作る
    @comics = []
    @title = params[:title]
    if @title.present?
      # ここでresultsに楽天APIから取得したデータを格納する
      results = RakutenWebService::Books::Book.search({
                                                        title: @title
                                                      })
      # ここで@comicsにAPIから取得したJSONデータを格納する
      results.each do |result|
        comic = Comic.new(read(result))
        @comics << comic
      end
    end
  end

  def create
    comic = Comic.find_or_initialize_by(isbn: params[:isbn])
    # @comics内の各データをそれぞれ保存する/すでに保存済のものは除外？
    unless comic.persisted?
      results = RakutenWebService::Books::Book.search(isbn: comic.isbn)
      comic = Comic.new(comic_params)
      if  comic.save
        redirect_to admin_comics_path, notice: 'コミックを追加しました'
      else
        render :search
      end
    end
  end

  def index
    @comics = Comic.all
  end

  def show
    @comic = Comic.find_by(isbn: params[:isbn])
  end

  def edit
    @comic = Comic.find_by(isbn: params[:isbn])
    @categories = Category.all
  end

  def update
    @comic = Comic.find_by(isbn: params[:isbn])
    if @comic.update!(comic_params)
      redirect_to admin_comic_path(@comic.isbn), notice: '更新しました'
    else
      @categories = Category.all
      render :edit
    end
  end

  def destroy
    @comic = Comic.find_by(isbn: params[:isbn])
    @comic.destroy
    redirect_to admin_comics_path, notice: '削除しました'
  end

  private

  def comic_params
    params.require(:comic).permit(
      :category_id,
      :body,
      :title,
      :author,
      :publisher,
      :url,
      :isbn,
      :image_url,
      :item_caption
    )
  end

  def read(result)
    title = result['title']
    author = result['author']
    publisher = result['publisherName']
    url = result['itemUrl']
    isbn = result['isbn']
    image_url = result['mediumImageUrl'].gsub('?_ex=120x120', '')
    item_caption = result['itemCaption']
    {
      title: title,
      author: author,
      publisher: publisher,
      url: url,
      isbn: isbn,
      image_url: image_url,
      item_caption: item_caption
    }
  end
end
