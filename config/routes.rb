Rails.application.routes.draw do
  devise_for :administrators, module: "administrators"
  devise_for :users, module: "users"

  resources :user_details, only: [:index, :show, :destroy]

  devise_scope :administrator do
    root to: 'administrators/sessions#new'
  end
end
