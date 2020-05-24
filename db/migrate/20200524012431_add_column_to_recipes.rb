class AddColumnToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :api_id, :integer,  :default => nil
  end
end
