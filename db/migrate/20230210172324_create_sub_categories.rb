class CreateSubCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :sub_categories do |t|
      t.references :category, foreign_key: true, index: true

      t.string :name
      t.text   :description

      t.timestamps
    end
  end
end
