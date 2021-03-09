Rails.application.routes.draw do
  get 'admin/index'
  get 'rooms/index'
  get 'rooms/show'
  root 'static_pages#home'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users do
    get :search, on: :collection
  end

  #devise_scope :users do
    #get '/users', to: redirect("/users/sign_up")
  #end
  resources :users, only: [:index, :search]
  resources :admin, only: [:index, :destroy]
  resources :mypage, only: [:show]
  resources :schedules, only: [:new, :create, :edit, :update]
  resources :rooms, only: [:index, :create, :show]
  resources :messages, only: [:create]
  resources :relations, only: [:create, :destroy]
  resources :talent_profiles, only: [:edit, :update,]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
