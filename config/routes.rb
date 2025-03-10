Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  devise_for :users
  
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorite, only: [:create, :destroy]
    #単数形にすると、/:idがURLに含まれない
    #1回しかいいねできないからfavoriteのidが分からなくてもuserのid、bookのidで特定できる
    resources :book_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
  	  get "followers" => "relationships#followers", as: "followers"
      #viewページ用のルーティング
  end

  get "/search", to: "searches#search"
  #検索機能にアクセスするためのルーティング
end
