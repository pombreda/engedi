Rails.application.routes.draw do
  resources :sections

  resources :course_sections
  resources :course_groups
  resources :lectures
  resources :periods

  resources :rooms do
    collection do
      get :importer
      post :import
    end
  end

  resources :lecturers do
    collection do
      get :importer
      get :random
      post :import
    end
  end

  resources :courses do
    collection do
      get :importer
      post :import
    end
  end

  resources :schedules

  get '/resources', :to => 'resources#index', :as => 'resources'
  get '/resources/sync', :to => 'resources#sync', :as => 'resources_sync'
  post '/resources/run_sync', :to => 'resources#run_sync', :as => 'resources_run_sync'

  # root path
  root 'home#index'
end
