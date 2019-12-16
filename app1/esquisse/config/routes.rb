Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show,:profile]

  resources :photos, only: [:index, :show, :create,:view] do
    resources :favorites, only: [:create, :destroy]
  end

#  root 'users#sign_in'                         #ログイン後画面の表示
  root 'photos#index'
  get ':id/profile' => 'users#profile'          #プロフィール編集画面の表示
  post ':id/update' => 'users#update'           #プロフィール更新アクション
  get ':id/post' => 'photos#post_form'          #投稿フォームの表示
  post 'create' => 'photos#create'              #投稿アクション
  get 'view' => 'photos#view'                   #一覧
  post ':id/destroy' => 'photos#post_destroy'   #投稿削除
  post ':id/fav_cancel' => 'photos#fav_cancel'  #いいね!取り消しアクション
  get ':id/favorite' => 'favorites#view'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
