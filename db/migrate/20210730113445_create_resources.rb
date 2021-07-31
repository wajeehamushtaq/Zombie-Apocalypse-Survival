class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.string :item_name
      t.integer :points

      t.timestamps
    end
  end
end
