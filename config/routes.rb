Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show]
      resources :feedbacks, only: [:index, :create, :show, :update, :destroy]
      resources :comments, only: [:create, :destroy]
      patch 'likes', to: 'likes#update'
      # delete '/likes', to: 'likes#destroy'
      
      get '/parent_comments', to: "comments#parent_comments"
      get '/replies', to: "comments#replies"

      get '/is_logged_in', to: 'sessions#is_logged_in'
      post '/login', to: 'sessions#create'
      delete '/signout', to: 'sessions#destroy'

      get '/status_count', to: 'feedbacks#status_count'
      get '/feedbacks_by_statuses', to: 'feedbacks#feedbacks_by_statuses'
      
      post '/signup', to: 'users#create'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
