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
Follow.destroy_all

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
# end

user1 =  User.create(name: 'wyy', password: '123')
user2 = User.create(name: 'Gordon Ramsay', password: '123')
user3 = User.create(name: 'Thomas Keller', password: '123')
user4 = User.create(name: 'lucky', password: '123')

follow1 = Follow.create(user_id: user1.id, following_id: user2.id)
follow2 = Follow.create(user_id: user1.id, following_id: user3.id)
follow3 = Follow.create(user_id: user1.id, following_id: user4.id)
follow4 = Follow.create(user_id: user4.id, following_id: user1.id)

recipe1 = Recipe.create(title: "Hawaiian Pork Burger", 
    image: "https://spoonacular.com/recipeImages/245166-556x370.jpg", 
    steps: "Make burger mixture: Use your (clean) hands to mix the ground pork, green onion, allspice, salt, pepper and ground ginger together in a large bowl until just combined. Don't knead the mixture too much or the burgers will be tough.\n\nForm patties: Gently form 4 equal patties, with a slight indentation in the middle (the burgers will contract as they cook, the indentation helps keep the burgers from bulging in the middle too much).\n\nIf you want, you can separate the patties with wax paper and store them for a few hours in the fridge before grilling.\n\nGrill the patties: Prepare your grill for medium high, direct heat. Scrape down the grill grates and coat with vegetable oil.\nPlace the pork patties on the hot grill and paint the top with barbecue sauce.\n\nCover the grill and cook for 5-7 minutes. Flip the burgers and paint with more barbecue sauce.\n\nGrill pineapple rings: After you've flipped the burgers, lay the pineapple rings down on a hot part of the grill. Cook the burgers for another 5 to 7 minutes, until cooked through.\nCook the pineapple rings for 3-5 minutes, or until you have nice grill marks on one side. Flip the pineapple and grill another 1-2 minutes.\nRemove the pineapple and burgers from the grill and let them rest 5 minutes.\n\nToast burger buns on grill: While the meat is resting, toast the burger buns on the hot grill until the edges brown nicely, about 1-2 minutes.\n\nAssemble the burgers: To construct the burger, lay some lettuce on the bun, add the burger patty and paint with a little more barbecue sauce. Top with the ham, then the pineapple, then the other bun.\nServe immediately.",
    description: "Hawaiian Pork Burger requires roughly 40 minutes from start to finish. One serving contains 558 calories, 30g of protein, and 31g of fat. This dairy free recipe serves 4 and costs $1.71 per serving.",
    isPublic: true,
    user: user1)

ground_pork = Ingredient.create(name: 'pork')
green_onion = Ingredient.create(name: 'green onion')
ginger = Ingredient.create(name: 'ginger')
all_spice = Ingredient.create(name: 'allspice')
salt = Ingredient.create(name: 'salt')
black_pepper = Ingredient.create(name: 'black pepper')
pineapple = Ingredient.create(name: 'pineapple')
barbecue_sauce = Ingredient.create(name: 'barbecue sauce')
burger_bun = Ingredient.create(name: 'burger bun')
lettuce = Ingredient.create(name: 'lettuce')
ham = Ingredient.create(name: 'ham')

recipe1_ingredient1 = RecipeIngredient.create(recipe: recipe1, ingredient: ground_pork, quantity_number: 1, measurement: 'pound',instruction: 'ground pork')
recipe1_ingredient2 = RecipeIngredient.create(recipe: recipe1, ingredient: green_onion, quantity_number: 0.25, measurement: 'cups',instruction: 'minced')
recipe1_ingredient3 = RecipeIngredient.create(recipe: recipe1, ingredient: ginger, quantity_number: 0.5, measurement: 'teaspoons',instruction: 'ground ginger')
recipe1_ingredient4 = RecipeIngredient.create(recipe: recipe1, ingredient: all_spice, quantity_number: 0.125, measurement: 'teaspoons',instruction: '1/8 teaspoon ground allspice')
recipe1_ingredient5 = RecipeIngredient.create(recipe: recipe1, ingredient: salt, quantity_number: 0.125, measurement: 'teaspoons',instruction: '1/8 teaspoon salt (more to taste, but be careful, the BBQ sauce is salty, as is the ham)')
recipe1_ingredient6 = RecipeIngredient.create(recipe: recipe1, ingredient: black_pepper, quantity_number: 1, measurement: 'pinch',instruction: '')
recipe1_ingredient7 = RecipeIngredient.create(recipe: recipe1, ingredient: pineapple, quantity_number: 0.5, measurement: 'pounds',instruction: '4 pineapple rings, fresh or canned')
recipe1_ingredient8 = RecipeIngredient.create(recipe: recipe1, ingredient: barbecue_sauce, quantity_number: 0.25, measurement: 'cup',instruction: '1/4 cup your favorite barbecue sauce')
recipe1_ingredient9 = RecipeIngredient.create(recipe: recipe1, ingredient: burger_bun, quantity_number: 4, measurement: 'pieces',instruction: 'choose any burger buns you like')
recipe1_ingredient10 = RecipeIngredient.create(recipe: recipe1, ingredient: lettuce, quantity_number: 4, measurement: 'larges',instruction: '4 large lettuce leaves (use leafy lettuce)')
recipe1_ingredient11 = RecipeIngredient.create(recipe: recipe1, ingredient: ham, quantity_number: 0.25, measurement: 'pounds',instruction: 'thinly sliced ham')

tag1 = Tag.create(name: 'easy to prepare')
tag2 = Tag.create(name: 'quick')
tag3 = Tag.create(name: 'dairy free')
tag4 = Tag.create(name: 'main dish')
tag5 = Tag.create(name: 'American')

recipe1_tag1 = RecipeTag.create(recipe: recipe1, tag: tag1)
recipe1_tag2 = RecipeTag.create(recipe: recipe1, tag: tag2)
recipe1_tag3 = RecipeTag.create(recipe: recipe1, tag: tag3)
recipe1_tag4 = RecipeTag.create(recipe: recipe1, tag: tag4)

like1 = Like.create(user: user1, recipe: recipe1)
comment1 = Comment.create(user: user4, recipe: recipe1, text: "It's my first time eating a Hawaiian burger, and it's yummy!")

recipe2 = Recipe.create(title: "Falafel Burgers with Feta Cucumber Sauce", 
    image: "https://spoonacular.com/recipeImages/492564-556x370.jpg", 
    steps: "In a medium bowl combine all tzatziki ingredients and season to taste with salt and pepper. Refrigerate.\nTo make the burgers add ⅓ cup onion, parsley, lemon, cumin, coriander, salt, chickpeas and garlic to the bowl of a large food processor. Pulse until well combined and chickpeas are mostly smooth, scraping down sides of bowl occasionally.\nAdd the beans to a bowl and stir in the remaining ⅓ cup red onion and ⅓ cup of the bread crumbs. Put the remaining ⅓ cup bread crumbs into a shallow dish.\nMake 6 equal-sized ½-inch thick patties and dredge both sides in the bread crumbs.\nLiberally cover the bottom of a large skillet with oil and heat over medium heat. Cook burgers in batches 3 at a time about 4 minutes each side until lightly golden brown.\nServe tucked into pitas or on soft buns with feta tzatziki sauce, spinach leaves and tomatoes. Slice burgers in half before serving.",
    description: "Forget going out to eat or ordering takeout every time you crave American food. Try making Falafel Burgers with Feta Cucumber Sauce at home. One portion of this dish contains roughly 15g of protein, 8g of fat, and a total of 289 calories. This recipe serves 6.",
    isPublic: true,
    user: user1)
    
cucumber = Ingredient.create(name: 'cucumber')
greek_yogurt = Ingredient.create(name: 'greek yogurt')
cheese = Ingredient.create(name: 'cheese')
garlic = Ingredient.create(name: 'garlic')
lemon = Ingredient.create(name: 'lemon')
dill = Ingredient.create(name: 'dill')
red_onion = Ingredient.create(name: 'red onion')
cumin = Ingredient.create(name: 'cumin')
parsley = Ingredient.create(name: 'parsley')
coriander = Ingredient.create(name: 'coriander')
chickpeas = Ingredient.create(name: 'chickpeas')
breadcrumbs = Ingredient.create(name: 'breadcrumbs')
olive_oil = Ingredient.create(name: 'olive oil')
pita = Ingredient.create(name: 'pita')
tomato = Ingredient.create(name: 'tomato')
    
recipe2_ingredient1 = RecipeIngredient.create(recipe: recipe2, ingredient: cucumber, quantity_number: 0.05, measurement: 'pound', instruction: '1/2 cucumber, peeled, seeded, and diced small')
recipe2_ingredient2 = RecipeIngredient.create(recipe: recipe2, ingredient: greek_yogurt, quantity_number: 0.75, measurement: 'cups', instruction: '3/4 cup greek yogurt or sour cream')
recipe2_ingredient3 = RecipeIngredient.create(recipe: recipe2, ingredient: cheese, quantity_number: 0.3, measurement: 'cups', instruction: '1/3 cup feta cheese, crumbled')
recipe2_ingredient4 = RecipeIngredient.create(recipe: recipe2, ingredient: garlic, quantity_number: 4, measurement: 'clove', instruction: 'minced')
recipe2_ingredient5 = RecipeIngredient.create(recipe: recipe2, ingredient: lemon, quantity_number: 3, measurement: 'teaspoons', instruction: 'lemon juice, fresh squeezed')
recipe2_ingredient6 = RecipeIngredient.create(recipe: recipe2, ingredient: dill, quantity_number: 1, measurement: 'teaspoon', instruction: 'dried or fresh dill')
recipe2_ingredient7 = RecipeIngredient.create(recipe: recipe2, ingredient: salt, quantity_number: 1, measurement: 'teaspoon', instruction: 'salt or sea salt')
recipe2_ingredient8 = RecipeIngredient.create(recipe: recipe2, ingredient: red_onion, quantity_number: 0.6, measurement: 'cup', instruction: '2/3 cup red onion, chopped')
recipe2_ingredient9 = RecipeIngredient.create(recipe: recipe2, ingredient: parsley, quantity_number: 0.3, measurement: 'cup', instruction: '1/3 cup fresh Italian parsley, chopped')
recipe2_ingredient10 = RecipeIngredient.create(recipe: recipe2, ingredient: cumin, quantity_number: 1, measurement: 'teaspoon', instruction: 'ground cumin')
recipe2_ingredient11 = RecipeIngredient.create(recipe: recipe2, ingredient: coriander, quantity_number: 1, measurement: 'teaspoon', instruction: 'ground coriander')
recipe2_ingredient12 = RecipeIngredient.create(recipe: recipe2, ingredient: chickpeas, quantity_number: 31, measurement: 'ounces', instruction: 'cans chickpeas, drained and rinsed')
recipe2_ingredient13 = RecipeIngredient.create(recipe: recipe2, ingredient: breadcrumbs, quantity_number: 0.6, measurement: 'cups', instruction: 'seasoned breadcrumbs, divided')
recipe2_ingredient14 = RecipeIngredient.create(recipe: recipe2, ingredient: olive_oil, quantity_number: 1, measurement: 'serving', instruction: 'for pan-fying')
recipe2_ingredient15 = RecipeIngredient.create(recipe: recipe2, ingredient: lettuce, quantity_number: 1, measurement: 'serving', instruction: 'spinach or romaine lettuce')
recipe2_ingredient16 = RecipeIngredient.create(recipe: recipe2, ingredient: tomato, quantity_number: 1, measurement: 'serving', instruction: 'sliced')

recipe2_tag1 = RecipeTag.create(recipe: recipe2, tag: tag5)
recipe2_tag2 = RecipeTag.create(recipe: recipe2, tag: tag4)

like2 = Like.create(user: user1, recipe: recipe2)
comment1 = Comment.create(user: user2, recipe: recipe2, text: "It's the best Falafel Burgers ever!")
