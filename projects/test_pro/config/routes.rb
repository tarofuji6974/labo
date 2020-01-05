Rails.application.routes.draw do
  # root 'seaches#index'
  get 'searches' => 'searches#index'
end
