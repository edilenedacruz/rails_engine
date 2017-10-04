Rails.application.routes.draw do
  # namespace :api do
  #   namespace :v1 do
  #     namespace :merchants do
  #       get '/'
  #   end
  # end
  resources :merchants, only: [:index]
end
