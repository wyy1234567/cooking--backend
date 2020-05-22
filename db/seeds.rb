# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "json"
require "net/http"
require "open-uri"

User.destroy_all
Recipe.destroy_all
Ingredient.destroy_all
Like.destroy_all
Comment.destroy_all
Tag.destroy_all
RecipeIngredient.destroy_all
RecipeTag.destroy_all

# api_key = ENV['API_KEY']
# base_search = ['chicken', 'burger', 'beef', 'breakfast', 'dinner', 'corn']

# base_search.each do |search_word|
#     recipes_url = `https://api.spoonacular.com/recipes/search?apiKey=#{api_key}&query=#{search_word}`
#     resp = RestClient.get(recipes_url)
#     resp_json = JSON.parse(resp)

#     recipe_id = resp_json['result']['id']
#     recipe_title = resp_json['result']['title']

#     curr_recipe_url = `https://api.spoonacular.com/recipes/#{recipe_id}/information?apiKey=#{api_key}`
#     curr_recipe = RestClient.get(curr_recipe_url)
#     curr_recipe_json = JSON.parse(curr_recipe)

#     recipe_ingredients = curr_recipe_json["extendedIngredients"]  #array of hash
    
    #recipe_ingredients.each do |ingredient|
    




    
    