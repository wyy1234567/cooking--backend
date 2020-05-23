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
    
    def self.tag_recipes(tag_id)
        tag = Tag.find(tag_id)
        tag.recipes
    end

    def full_recipe_info(recipe_id)
        recipe={}
        recipe = {:recipe => self}
        recipe.merge!({:ingredients => self.ingredients})
        recipe.merge!({:likes => self.likes})
        recipe.merge!({:comments => self.comments})
        recipe.merge!({:tags => self.tags})
        recipe.merge!({:measurements => self.recipe_ingredients})
    end

end

