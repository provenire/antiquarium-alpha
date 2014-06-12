Rails.application.routes.draw do
  
  # Root
  root 'home#index'
  
  
  # Artifacts
  resources :artifacts
  
end
