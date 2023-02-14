class CreateProductColors < ActiveRecord::Migration[7.0]
  def change
    create_table :product_colors do |t|
      t.references :product, foreign_key: true, index: true
      t.references :color,   foreign_key: true, index: true

      t.timestamps
    end
  end
end
