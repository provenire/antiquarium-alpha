Rails.application.routes.draw do
  
  # Root
  root 'home#index'
  
  
  # Artifacts
  resources :artifacts do
    resources :photos
  end
  
  
  # People
  get '/people/find', to: 'people#find', as: 'find_people'
  resources :people do
    resources :photos
  end
  
  
  # Places
  get '/places/find', to: 'places#find', as: 'find_places'
  resources :places do
    resources :photos
  end
  
  
  # Employments
  resources :employments
  
  
  # Photos
  resources :photos
  
end
