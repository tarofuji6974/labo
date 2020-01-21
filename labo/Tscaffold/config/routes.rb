Rails.application.routes.draw do
  devise_for :users

  resources :theme, :replace_id_with => 'url'
  resources :comment
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'theme#profile'

  get 'create/:id' => 'theme#create'
  post 'create_theme' => 'theme#create_theme'
  get 'profile/:id' => 'theme#profile'
  get 'profile_edit/:id' => 'theme#profile_edit'
  get 'theme_edit/:id/:url' => 'theme#theme_edit'  #お題編集ページ
  get 'theme_update/:id' => 'theme#theme_update'
  get 'theme_answer/:id/:url' => 'theme#theme_answer' #お題の個別ページ
  post 'comments/:id' => 'theme#comments' #コメントの投稿
  post 'profile_update/:id' => 'theme#profile_update'
  get 'view' => 'theme#view'
  get 'theme_edit/:id/:url' => 'theme#theme_edit'
  post 'delete/:id' => 'theme#delete'

end
