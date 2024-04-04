Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  begin
    ActiveAdmin.routes(self)
  rescue StandardError
    ActiveAdmin::DatabaseHitDuringLoad
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :users do
    post "token" => "users/refresh#create"
  end


  devise_for :users,
             path: "",
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               registration: "signup"
             },
             controllers: {
               sessions: "users/sessions",
               registrations: "users/registrations"
             }
  
  api_version(module: "V1", header: { name: "Accept-Version", value: "v1" }) do
    post '/users/auth/kakao' => 'users#kakao'
    post '/users/auth/naver' => 'users#naver'
    get '/users/auth/naver' => 'users#naver'
    resources :objects
    resources :images do
      post :dropzone, on: :collection
    end
    resources :users, only: %i[index show update], shallow: true do
      get :me, on: :collection
      patch :image, on: :collection
      member do
        get :obtain_medals
      end
      resources :notifications, only: %i[index create update]
    end
    namespace :phone_certifications do
      get :sms_auth
      get :check
    end
    resources :orders
  end
end
