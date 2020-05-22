class CreateRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_ingredients do |t|
      t.integer :recipe_id 
      t.integer :ingredient_id
      t.float :quantity_number
      t.string :measurement
      t.string :instruction
      t.timestamps
    end
  end
end
