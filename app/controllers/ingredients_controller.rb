class IngredientsController < ApplicationController
    # create
    ### though will this be handled in the recipe interaction instead?
    def index
        ingredients = Ingredient.all 
        render json: ingredients, except: [:created_at, :updated_at]
    end
end
