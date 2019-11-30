Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/' => "home#login" #ログイン画面
  post 'home/index' => 'home#index' #ログインアクション
  post 'logout' => 'home#logout'
  get 'signup' => 'users#new' #ユーザー登録画面
  post 'users/create' => 'users#create'  #ユーザー登録アクション
  get 'users/:id' => 'users#index'  #ユーザー個別画面
  get 'edit' => "users#edit"  #ユーザー編集画面
  get 'view' => 'posts#view'  #一覧画面
  get 'post_form' => 'posts#post_form'  #投稿画面
  get 'favorite' => 'posts#favorite'  #お気に入り画面

end
