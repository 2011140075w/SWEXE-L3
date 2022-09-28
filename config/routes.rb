Rails.application.routes.draw do
  root 'tweets#index'
  resources :tweets, only: %i[index show new create edit update destroy]
  get 'get_image/:id', to: 'tweets#get_image'
end
