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
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  # ネストする 
  scope module: :user do
    resources :sneakers, only:[:new, :edit, :index, :show, :create, :update, :destroy] do
       resources :sneaker_comments, only:[:create, :destroy]
       resource :favorites, only: [:create, :destroy]
    end
    # ネストする
    resources :users, only:[:new, :show, :edit, :index,  :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
  end
  
  
  get "about" => "user/homes#about"
  root to: 'user/homes#top'
  
end
