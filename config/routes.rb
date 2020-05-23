Rails.application.routes.draw do
  # resources :recipe_tags
  resources :tags
  # resources :recipe_ingredients
  resources :ingredients
  resources :likes
  resources :comments
  # resources :users
  # resources :recipes
  
  get "/:user_id/recipes", to: "recipes#show_user_recipes"
  get "/:user_id/following_recipes", to: "recipes#following_recipes"
  get "/recipes/:id", to: "recipes#show"
  get '/tag/:tag_id/recipes', to: 'recipes#tag_recipes'

  get 'users/login/:id', to: "users#login"
  post 'users/register', to: "users#register"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
