Rails.application.routes.draw do
  devise_for :administrators, module: "administrators"
  devise_for :users, module: "users"

  resources :admin_user_details, only: [:index, :show, :destroy]

  devise_scope :administrator do
    root to: 'administrators/sessions#new'
    get 'admin/login' => 'administrators/sessions#new', as: :new_admin_session
    post 'admin/login' => 'administrators/sessions#create', as: :admin_session
    delete 'admin/sign_out' => 'administrators/sessions#destroy', as: :destroy_admin_session
  end
end
