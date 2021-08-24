Rails.application.routes.draw do
  devise_for :administrators, module: "administrators"
  devise_for :users, module: "users"

  root to: 'users/mypages#index'
  
  scope module: :administrators do
    resources :admin_user_details, only: [:index, :show, :destroy]
  end

  namespace :users do
    resources :mypages, only: [:index, :show, :edit, :update] do
      get 'password', on: :member
      patch 'password_update', on: :member
      post 'confirm', on: :member
    end
  end

  devise_scope :administrator do
    get 'admin/login' => 'administrators/sessions#new', as: :new_admin_session
    post 'admin/login' => 'administrators/sessions#create', as: :admin_session
    delete 'admin/sign_out' => 'administrators/sessions#destroy', as: :destroy_admin_session
  end

  devise_scope :user do
    post 'users/sign_up/confirm', to: 'users/registrations#confirm'
  end

  get 'top' => 'users/mypages#index', as: :top
  get '*unmatched_route', :to => 'application#routes_not_found!', format: false
end
