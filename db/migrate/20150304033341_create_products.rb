class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products, id: false do |t|
      t.primary_key :id
      t.timestamps null: false
    end
  end

  def down
    drop_table :products
  end
end
