Rails.application.routes.draw do
  devise_for :administrators, module: "administrators"
  devise_for :users, module: "users"

  devise_scope :administrator do
    root to: 'administrators/sessions#new'
  end
end
