class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :sub_category, foreign_key: true, index: true

      t.string :name
      t.text   :description

      t.float :price
      t.float :discounted_price

      t.boolean :on_sale, default: false

      t.timestamps
    end
  end
end
