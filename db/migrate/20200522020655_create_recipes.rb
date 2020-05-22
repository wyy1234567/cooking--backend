class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :image
      t.string :description
      t.string :steps
      t.integer :user_id
      t.boolean :isPublic, :default => false
      t.timestamps
    end
  end
end
