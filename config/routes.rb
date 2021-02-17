Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'devise/admins/sessions',
    passwords: 'devise/admins/passwords',
    registrations: 'devise/admins/registrations'
  }
  devise_for :users, controllers: {
    sessions: 'devise/users/sessions',
    passwords: 'devise/users/passwords',
    registrations: 'devise/users/registrations'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Admin側
  namespace :admin do
    # TopページをHomeに変更
    get '/' => 'homes#top'
    # get "search/homes" => "homes#search", as: 'homes_search'

    get 'comics/:isbn' => 'comics#show', as: 'comic'
    get 'comics/:isbn/edit' => 'comics#edit', as: 'comic_edit'
    patch 'comics/:isbn' => 'comics#update', as: 'comic_update'
    delete 'comics/:isbn' => 'comics#destroy', as: 'comic_destroy'
    get 'search/comics' => 'comics#search', as: 'comics_search'
    resources :comics, only: %i[index create]

    resources :categories, except: %i[new show destroy]
    resources :users, only: %i[index show]
  end

  # User側
  scope module: :public do
    # Topページ
    root to: 'homes#top'
    # aboutページ
    get 'homes/about' => 'homes#about'
    # user周りのルート
    resources :users, except: %i[new create destroy]
    get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'user_unsubscribe'
    patch 'users/:id/withdraw' => 'users#withdraw', as: 'user_withdraw'
    get 'search' => 'users#search', as: 'user_search'
    # フォロー機能
    resources :relationships, only: %i[create destroy]
    get 'relationships/follows' => 'relationships#follow', as: 'relationships_follows'
    get 'relationships/followers' => 'relationships#follower', as: 'relationships_followers'
    # Comic関連のルーティング
    # カテゴリー検索
    get 'category/search' => 'homes#search', as: 'search_comics'
    get 'comics/:isbn' => 'comics#show', as: 'comic'
    resources :comics, only: [:index] do
      # レビュー機能
      resources :reviews do
        resources :comments, only: %i[create destroy]
        resource :likes, only: %i[create destroy]
      end
      # Tag機能
      resources :tags, only: %i[create destroy] # do
      # get 'search', to: 'tag#search'
      # end
    end
    get 'tags/:tag_name/search' => 'tags#search', as: 'tag_search'
  end
end
