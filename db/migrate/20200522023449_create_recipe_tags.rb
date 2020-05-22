class CreateRecipeTags < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_tags do |t|
      t.string :recipe_id 
      t.string :tag_id
      t.timestamps
    end
  end
end
