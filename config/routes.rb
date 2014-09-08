Rails.application.routes.draw do
  
  # Root
  root 'home#index'
  
  
  # Admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  
  # Resque
  # mount ResqueWeb::Engine => "/resque"
  mount Resque::Server, :at => '/resque'
  
  
  # Users
  devise_for :users
  
  
  # Search
  get '/search', to: 'search#index', as: 'search'
  
  
  # Artifacts
  get '/artifacts/:id/history', to: 'artifacts#history', as: 'artifact_history'
  resources :artifacts do
    resources :photos
    resources :events
  end
  
  
  # People
  get '/people/:id/history', to: 'people#history', as: 'person_history'
  get '/people/find', to: 'people#find', as: 'find_people'
  resources :people do
    resources :photos
  end
  
  
  # Places
  get '/places/:id/history', to: 'places#history', as: 'place_history'
  get '/places/find', to: 'places#find', as: 'find_places'
  resources :places do
    resources :photos
  end
  
  
  # Events
  get '/events/:id/history', to: 'events#history', as: 'event_history'
  get '/events/actors', to: 'events#actors', as: 'find_actors'
  resources :events do
    resources :citations
  end
  
  
  # Employments
  get '/employments/:id/history', to: 'employments#history', as: 'employment_history'
  resources :employments
  
  
  # Photos
  get '/photos/:id/history', to: 'photos#history', as: 'photo_history'
  resources :photos
  
  
  # Sources
  get '/sources/:id/history', to: 'sources#history', as: 'source_history'
  get '/sources/find_book', to: 'sources#find_book', as: 'find_book'
  resources :sources
  
  
  # Citations
  resources :citations
  
  
  # Workflows
  get '/workflows/website', to: 'workflows#website', as: 'website_workflow'
  get '/workflows/extract', to: 'workflows#extract', as: 'extract_workflow'
  
end
