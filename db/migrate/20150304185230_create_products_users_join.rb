class CreateProductsUsersJoin < ActiveRecord::Migration
  def change
    create_table :products_users, id: false do |t|

      t.integer "product_id"
      t.integer "user_id"

    end
    add_index :products_users, ["product_id", "user_id"]
  end
end
