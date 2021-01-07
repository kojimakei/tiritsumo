Rails.application.routes.draw do
  
  # ゲストユーザーを削除できないようにする
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'stacks#index'
  resources :stacks

  # 簡単ログイン機能のルーティン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
end
