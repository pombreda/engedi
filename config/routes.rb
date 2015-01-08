Rails.application.routes.draw do
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

  # root path
  root 'home#index'
end
