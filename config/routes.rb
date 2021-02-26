Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions',
  }
  
  root to: 'stacks#index'
  resources :stacks do
    # 達成可否判断ルーティング
    member do
      get 'achieved'
    end
    resources :comments, only: %i[create destroy]
    resource :likes, only: %i[create destroy]
  end

  resources :users, only: [:edit, :show, :update] do
    collection do
      get 'ranking'
    end
  end

  resources :rooms do
    resources :chats, only: [:create]
    member do
      get 'join'
    end
  end


  # 簡単ログイン機能のルーティン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

end
