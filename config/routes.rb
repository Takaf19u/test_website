Rails.application.routes.draw do
  devise_for :administrators, module: "administrators"
  devise_for :users, module: "users"
end
