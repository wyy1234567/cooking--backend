Rails.application.routes.draw do
  # resources :recipe_tags
  resources :tags
  # resources :recipe_ingredients
  resources :ingredients
  resources :likes
  resources :comments
  # resources :users
  # resources :recipes
  
  get 'search/recipes/:query', to: 'recipes#search'
  get "/recipes", to: "recipes#show_user_recipes"
  get "/recipes/following_recipes", to: "recipes#following_recipes"
  get '/recipes/by_tag/:tag_id', to: 'recipes#tag_recipes'
  get "/recipes/:id", to: "recipes#show"

  post '/users/login', to: "users#login"
  post '/users/register', to: "users#register"
  post '/users/logout', to: "users#logout"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
