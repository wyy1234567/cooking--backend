Rails.application.routes.draw do
  resources :recipe_tags
  resources :tags
  resources :recipe_ingredients
  resources :ingredients
  resources :likes
  resources :comments
  resources :users
  resources :recipes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
