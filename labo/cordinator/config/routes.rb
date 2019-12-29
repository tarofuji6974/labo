Rails.application.routes.draw do
  #resources :meetings
  get 'tasks/index'
  get 'events/index'
  get 'events/show'
  get 'meetings/index'
  post 'create' => 'events#create'
  get 'events/create/:id' => 'events#view'

  root 'home#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
