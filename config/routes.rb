
IshLibManager::Engine.routes.draw do
  
  root :to => 'welcome#home'

  devise_for :users, :controllers => {
    :sessions => "users/sessions",
    :registrations => 'users/registrations'
  }
  devise_scope :user do
    post 'sign_in', :to => 'users/sessions#create', :as => :session
  end
  
  resources :cities do
    resources :communities
    resources :events
    resources :features
    resources :galleries
    resources :newsitems
    resources :reports
    resources :users
    resources :venues
    resources :videos
  end

  resources :galleries
  ## below, obsolete. Let's not have this complexity. _vp_ 20160507
  # get 'galleries_title', :to => 'galleries#index_title', :as => :galleries_title
  # get 'galleries_thumb', :to => 'galleries#index_thumb', :as => :galleries_thumb
  # get 'galleries_mini', :to => 'galleries#index_mini', :as => :galleries_mini

  # photos
  get 'photos/without_gallery', :to => 'photos#without_gallery', :as => :photos_without_gallery
  resources :photos
  # get 'photos/:id', :to => 'photos#show', :as => :photo
  # delete 'photos/:id', :to => 'photos#delete'
    
  # get 'reports', :to => 'reports#index', :as => :reports
  # post 'reports', :to => 'reports#create'
  get 'reports/without_site', :to => 'reports#index', :as => :reports_without_site, :site => false
  resources :reports
    
  get 'sites/:site_id/reports', :to => 'reports#index', :as => :site_reports
  get 'sites/trash', :to => 'sites#trash', :as => :sites_trash
  resources :sites do
    resources :newsitems
    resources :features
    resources :galleries
    resources :reports
    resources :vides
  end

  resources :tags do
    resources :features
    resources :newsitems
    
    resources :galleries
    resources :reports
    resources :videos
  end

  resources :users do
    resources :galleries
    resources :reports
    resources :videos
  end

  resources :venues do
  end
end
