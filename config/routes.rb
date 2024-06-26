Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad

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
    resources :users, only: %i[index show update], shallow: true do
      get :me, on: :collection
      patch :image, on: :collection
      resources :notifications, only: %i[index create update]
    end
    namespace :phone_certifications do
      get :sms_auth
      get :check
    end
    resources :orders
    resources :groups do
      collection do
        get :before_perform
      end
    end
    resources :videos, only: :index
    resources :images do
      collection do
        post :dropzone
        get :recent_images
      end
    end
    resources :reservations, only: %i[index create] do
      collection do
        get :for_day
      end
    end
  end
end
