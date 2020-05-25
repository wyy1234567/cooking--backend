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
        # recipes = Recipe.find_user_recipes(params[:user_id].to_i)
        recipes = []
        if current_user then
            puts "we have a user"
            recipes = current_user.recipes
        else
            puts "No current user"
            # recipes = Recipe.all
        end
        render json: recipes, :include => :user, except: [:created_at, :updated_at]
    end
    
    #render recipes that are posted by user's followings, given user_id, route: /:user_id/following_recipes 
    def following_recipes
        recipes = Recipe.find_following_recipes(params[:user_name])
        render json: recipes, :include => :user, except: [:created_at, :updated_at]
    end
    
    #recipe list of given tag name, given tag_id, route: /tag/:tag_id/recipes
    def tag_recipes 
        recipes = Recipe.tag_recipes(params[:tag_name])
        render json: recipes, :include => :user, except: [:created_at, :updated_at]
    end
    
    #show details about this recipe, along with its ingredients, likes, comments, tags
    def show
        recipe = Recipe.find(params[:id])
        if params[:id].include?('A')
        end
        puts "We have a recipe match"
        details = recipe.full_recipe_info(params[:id].to_i)
        puts details
        render json: details, except: [:created_at, :updated_at]
    end
    
    #given a recipe title, seach for recipes that match the query 
    def search 
        # recipes = Recipe.search_recipes(params[:query])
        recipes = Recipe.api_search(params[:query])
        render json: recipes, :include => :user, except: [:created_at, :updated_at]
    end
    
    def create
        puts "CREATE RECIPE"
        puts recipe_params

        recipe = Recipe.new(recipe_params)
        recipe.user = current_user

        if recipe.save then
            puts "valid recipe"
        else
            puts "INVALID RECIPE"
        end
        render json: recipe, except: [:created_at, :updated_at]
    end

    def update
        recipe = Recipe.find(params[:id])

        puts "UPDATE RECIPE"
        puts recipe_params

        recipe.update(recipe_params)

        if recipe.valid? then
            puts "valid recipe"
        else
            puts "INVALID RECIPE"
        end

        render json: recipe, except: [:created_at, :updated_at]
    end

    def destroy 
        recipe = Recipe.find(params[:id])
        recipe.destroy
    end


    private 
    def recipe_params
        params.require(:recipe).permit(:title, :image, :description, :steps, :isPublic)
    end
end
