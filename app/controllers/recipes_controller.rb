class RecipesController < ApplicationController
    # index (based on given user_id)
    # show
    # create (includes all the join tables and related elements)
    # update (includes all the join tables and related elements)
    # delete

    # social 
    # search --> this should be its own distinct thing
    ### wait on this one for later

    #render recipes list of a user, given user id, route: /:user_id/recipes
    def show_user_recipes
        recipes = Recipe.find_user_recipes(params[:user_id].to_i)
        render json: recipes, except: [:created_at, :updated_at]
    end
    
    #render recipes that are posted by user's followings, given user_id, route: /:user_id/following_recipes 
    def following_recipes
        recipes = Recipe.find_following_recipes(params[:user_id].to_i)
        render json: recipes, except: [:created_at, :updated_at]
    end
    
    #show details about this recipe, along with its ingredients, likes, comments, tags
    def show
        recipe = Recipe.find(params[:id])
        render json: recipe, except: [:created_at, :updated_at]
    end

    private 
    def recipe_params
        params.require(:recipe).permit(:title, :image, :description, :steps, :user_id, :isPublic)
    end
end
