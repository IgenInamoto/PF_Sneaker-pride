Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # 会員用
# URL /customers/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations], controllers: {
    sessions: "admin/sessions"
  }
  
  # 管理者側
  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:show, :index, :destroy]
    # ネストする
    resources :sneakers, only: [:show, :index, :destroy] do
    resources :sneaker_comments, only: [:destroy]
    end
  end
  
  # ユーザー側
  #ネストする 
  scope module: :user do
    # 退会確認画面
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
    patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
    resources :sneakers, only:[:new, :edit, :index, :show, :create, :update, :destroy] do
       resources :sneaker_comments, only:[:create, :destroy]
       resource :favorites, only: [:create, :destroy]
    end
    # ネストする
    resources :users, only:[:new, :show, :edit, :index,  :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
  end
  
  
  get "about" => "user/homes#about"
  root to: 'user/homes#top'
  
  # 検索用
  get '/search', to: 'user/searches#search'

  
end
