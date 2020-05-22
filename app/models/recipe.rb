class Recipe < ApplicationRecord
    has_many :likes
    has_many :comments
    has_many :recipe_tags
    has_many :recipe_ingredients
    has_many :tags, through: :recipe_tags
    has_many :ingredients, through: :recipe_ingredients
    belongs_to :user
end

