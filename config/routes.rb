Rails.application.routes.draw do
  get 'admin/index'
  get 'steps_subscribe/step1'
  get 'steps_subscribe/step2'
  get 'steps_subscribe/step3'
  
  get 'steps_athlete/step1'
  get 'steps_athlete/step2'
  get 'steps_athlete/step3'
  resources :admin_parameters
  get 'search/index'
  resources :sports
  resources :subscriptions


  resources :campaigns do
    member do
    #  get 'athletes/:id/campaigns', to: 'campaigns#index', as: 'campaigns'
      get 'subscribe', to: 'subscriptions#new', as: 'new_subscription'
    end
  end 

  resources :friends
  get 'notifications/index'
  get 'dashboard/index'
  get 'dashboard/activities'
  get 'dashboard/revenues'
  get 'dashboard/monetization'
  get 'dashboard/guides'

  resources :associations

  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'users/show'
  get 'users/:id' => 'users#show', as: 'user'

  
  get 'home/index'
  get 'search/index'


  resources :fans do
    member do
      post :edit
    end
  end

  resources :athletes do
    member do
      post :edit
    end
  end

  resources :comments, only: [] do
    resources :comments, only: %i[new create destroy], module: :comments
  end
  get '/comments/:id', to: 'comments#show', as: 'comment'
  
  resources :posts do
    resources :comments, only: %i[new create destroy], module: :posts

    member do 
      patch :upvote
      patch :downvote
      patch :vote
    end
  end

  root "home#index"
end
