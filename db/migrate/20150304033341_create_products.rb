class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products, id: false do |t|

      t.string :image_url
      t.string :retailer_url
      t.string :name
      t.text :description
      t.string :price
      t.string :retailer
      t.string :brand_name
      t.string :color
      t.primary_key :search_param

      t.timestamps null: false
    end
  end

  def down
    drop_table :products
  end
end
