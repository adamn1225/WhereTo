Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  root 'pages#index'

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end

  resources :users

  resources :restaurants

  resources :polls do
    resources :poll_responses, only: [:create, :index]
    resources :orders, only: [:create, :index, :show]
  end


end
