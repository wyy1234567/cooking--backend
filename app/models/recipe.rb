class Recipe < ApplicationRecord
    has_many :likes
    has_many :comments
    has_many :recipe_tags
    has_many :recipe_ingredients
    has_many :tags, through: :recipe_tags
    has_many :ingredients, through: :recipe_ingredients
    belongs_to :user

    def self.find_user_recipes(user_name)
        user = User.find_by(name: user_name)
        Recipe.all.select do |recipe|
            recipe.user_id == user.id
        end
    end

    def self.find_following_recipes(user_name)
        user = User.find_by(name: user_name)
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
    
    def self.tag_recipes(tag_name)
        tag = Tag.find_by(name: tag_name)
        tag.recipes
    end

    def full_recipe_info(recipe_id)
        recipe={}
        recipe = {:recipe => self}
        recipe.merge!({:user => self.user})
        # recipe.merge!({:ingredients => self.ingredients})
        recipe.merge!({:likes => self.likes})
        recipe.merge!({:comments => self.comments})
        recipe.merge!({:tags => self.tags})
        recipe.merge!({:ingredients => self.measurements})
    end

    def measurements
        self.recipe_ingredients.map do |ri|
            {id: ri.ingredient.id, name: ri.ingredient.name, quantity_number: ri.quantity_number, measurement: ri.measurement, instruction: ri.instruction}
        end
    end


    def self.search_recipes(query)
        Recipe.all.select do |recipe|
            recipe.title.downcase.include?(query.downcase)
        end
    end

    #create a Recipe object based on a given API search result
    #result is an array of objects, iterate over it, and create recipe for each element
    def self.convert(recipe_obj, user_id)
        recipe_title = recipe_obj['title']
        image_url = `https://spoonacular.com/recipeImages/#{recipe_title.parameterize}-#{recipe_obj['id']}.jpg`
        Recipe.create(title: recipe_title, image: image_url, user_id: user_id, isPublic: true, api_id: recipe_obj['id'])
    end

    #add steps, descriptions to recipe, also create recipe_ingredient and recipe_tag
    def self.relation_recipe(recipe_id, api_response)
        recipe = Recipe.find(recipe_id)
        recipe.steps = api_response['instructions']
        recipe.description = api_response['summary']
        ingredients_arr = api_response['extendedIngredients']

        ingredients_arr.each do |ingredient|
            ing = Ingredient.find_by(name: ingredient['name'])
            if ing #if ingredient exist, create join table for with this recipe and existing ingredient
                RecipeIngredient.create(recipe: recipe, ingredient: ing, quantity_number: ingredient['measures']['us']['amount'].to_f, measurement: ingredient['measures']['us']['unitLong'], instruction: ingredient['originalString'])
            else #if ingredinet is new, create new ingredient first, then relate new ingredient and this recipe
                new_ing = Ingredient.create(name: ingredient['name'])
                RecipeIngredient.create(recipe: recipe, ingredient: new_ing, quantity_number: ingredient['measures']['us']['amount'].to_f, measurement: ingredient['measures']['us']['unitLong'], instruction: ingredient['originalString'])
            end
        end

        #possible tags that the api response gives
        tags_arr = (api_response['cuisines'] + api_response['dishTypes']).uniq
        tags_arr.each do |t|
            tag = Tag.find_by(name: t)
            if tag #if tag is already exist, relate recipe and tag
                RecipeTag.create(recipe: recipe, tag: tag)
            else
                new_tag = Tag.create(name: t)
                RecipeTag.create(recipe: recipe, tag: new_tag)
            end
        end
    end

    def set_tags(tags)
        self.tags = []
        tags.each do |tag_param|
            tag = Tag.find_or_create_by(name: tag_param[:name])
            puts tag
            self.tags << tag
        end
    end

    def set_ingredients(ingredients)
        self.ingredients = []
        ingredients.each do |ing_param|
            puts "INGREDIENT PARAM"
            puts ing_param
            ing = Ingredient.find_or_create_by(name: ing_param[:name])
            ri = RecipeIngredient.new(recipe: self, ingredient: ing)
            # set the other metadata
            ri.quantity_number = ing_param[:quantity_number]
            ri.measurement = ing_param[:measurement]
            ri.instruction = ing_param[:instruction]
            ri.save
        end
    end

end
