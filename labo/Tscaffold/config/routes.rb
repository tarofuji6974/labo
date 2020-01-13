Rails.application.routes.draw do
  devise_for :users

  resources :theme, :replace_id_with => 'url'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'theme#top'

  get 'create/:id' => 'theme#create'
  post 'create_theme' => 'theme#create_theme'
  get 'profile/:id' => 'theme#profile'
  get 'profile_edit/:id' => 'theme#profile_edit'
  get 'view' => 'theme#view'
end
