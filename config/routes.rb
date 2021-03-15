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
    collection do
      get 'search'
    end
    resources :comments, only: %i[create destroy]
    resource :likes, only: %i[create destroy]
  end
  #タグによって絞り込んだ投稿を表示するアクションへのルーティング
  resources :tags do
    get 'stacks', to: 'stacks#tag_search'
  end

  resources :users, only: [:index, :edit, :show, :update] do
    collection do
      get 'ranking'
    end
    collection do
      get 'search'
    end
    resource :relationships, only:[:create, :destroy]
    get 'follows' => 'relationships#follower'
    get 'followers' => 'relationships#followed'
  end

  resources :rooms do
    collection do
      get 'search'
    end
    resources :chats, only: [:create]
    member do
      get 'join'
    end
  end

  resources :user_rooms, only: [:destroy]
  # 簡単ログイン機能のルーティン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

end
