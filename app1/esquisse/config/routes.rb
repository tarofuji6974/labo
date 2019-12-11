Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show]

  resources :photos, only: [:index, :show, :create,:view] do
    resources :favorites, only: [:create, :destroy]
  end

  root 'photos#index'
  get ':id/post' => 'photos#post_form'
  post 'create' => 'photos#create'
  get 'view' => 'photos#view'
  post ':id/destroy' => 'photos#post_destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
