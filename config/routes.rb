Rails.application.routes.draw do
  devise_for :administrators, module: "administrators"
  devise_for :users, module: "users"

  scope module: :administrators do
    resources :admin_user_details, only: [:index, :show, :destroy]
  end

  scope module: :users do
    resources :mypages, only: [:show, :edit, :update] do
      get 'password', on: :member
      post 'confirm', on: :member
    end
  end

  devise_scope :administrator do
    root to: 'administrators/sessions#new'
    get 'admin/login' => 'administrators/sessions#new', as: :new_admin_session
    post 'admin/login' => 'administrators/sessions#create', as: :admin_session
    delete 'admin/sign_out' => 'administrators/sessions#destroy', as: :destroy_admin_session
  end

  devise_scope :user do
    post 'users/sign_up/confirm', to: 'users/registrations#confirm'
  end
end
