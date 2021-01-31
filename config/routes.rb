Rails.application.routes.draw do
  root 'static_pages#home'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  #devise_scope :users do
    #get '/users', to: redirect("/users/sign_up")
  #end

  resources :mypage, only: [:show]
  resources :relationships, only: [:create, :destroy]
  resources :talent_profiles, only: [:new, :edit, :create, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
