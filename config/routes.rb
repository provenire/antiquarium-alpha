Rails.application.routes.draw do
  
  # Users
  devise_for :users, skip: :registrations, path: ''
  resources :users, only: [:show, :update]
  get 'settings', to: 'users#edit',    as: :edit_user
  get 'profile',  to: 'users#profile', as: :user_profile
  
  
  # Root
  devise_scope :user do
    authenticated :user do
      root to: 'home#index'
    end
  
    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  
  
  # Admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  
  # Resque
  # mount ResqueWeb::Engine => "/resque"
  mount Resque::Server, :at => '/resque'
  
  
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
  get '/events/:id/history', to: 'events#history',   as: 'event_history'
  get '/events/actors',      to: 'events#actors',    as: 'find_actors'
  get '/events/artifacts',   to: 'events#artifacts', as: 'find_artifacts'
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
  get '/sources/find_document', to: 'sources#find_document', as: 'find_document'
  resources :sources
  resources :book,     controller: 'sources', path: 'sources'
  resources :website,  controller: 'sources', path: 'sources'
  resources :document, controller: 'sources', path: 'sources'
  
  
  # Interactions
  resources :interactions, only: [:show]
  
  
  # Citations
  resources :citations
  
  
  # Workflows
  get '/workflows/website', to: 'workflows#website', as: 'website_workflow'
  get '/workflows/extract', to: 'workflows#extract', as: 'extract_workflow'
  
  
  # Page Content
  resources :page_contents, only: :update
  
  
  # Stuff
  get '/roadmap', to: 'home#roadmap', as: 'roadmap'
  
end
