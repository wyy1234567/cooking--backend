class Recipe < ApplicationRecord
    has_many :likes
    has_many :comments
    has_many :recipe_tags
    has_many :recipe_ingredients
    has_many :tags, through: :recipe_tags
    has_many :ingredients, through: :recipe_ingredients
    belongs_to :user

    def self.find_user_recipes(user_id)
        Recipe.all.select do |recipe|
            recipe.user_id == user_id
        end
    end

    def self.find_following_recipes(user_id)
        user = User.find(user_id)
        following_ids = user.followings.map do |following|
            following.id 
        end
        recipes = []
        following_ids.each do |id|
            Recipe.all.each do |recipe|
                if recipe.user_id == id 
                    recipes << recipe
                end
            end
        end
        recipes
    end

    #TODO: create a funciton to add like/comment/tag/ingredients to current recipe, make it as an array
end

