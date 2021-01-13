Rails.application.routes.draw do


  root to: 'stacks#index'
  resources :stacks do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

    resources :users, only: [:edit, :show, :update]

  # ゲストユーザーを削除できないようにする
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # 簡単ログイン機能のルーティン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

end
