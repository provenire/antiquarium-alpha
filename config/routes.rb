Rails.application.routes.draw do
  
  # Root
  root 'home#index'
  
  
  # Artifacts
  resources :artifacts do
    resources :photos
  end
  
  
  # Photos
  resources :photos
  
end
