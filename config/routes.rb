Rails.application.routes.draw do
  
  # Root
  root 'home#index'
  
  
  # Artifacts
  resources :artifacts do
    resources :photos
    resources :events
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
  
  
  # Events
  get '/events/actors', to: 'events#actors', as: 'find_actors'
  resources :events
  
  
  # Employments
  resources :employments
  
  
  # Photos
  resources :photos
  
  
  # Sources
  resources :sources
  
  
  # Resque
  mount Resque::Server, :at => '/resque'
  
end
