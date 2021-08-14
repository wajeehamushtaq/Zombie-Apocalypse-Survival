class RemoveImageFromResources < ActiveRecord::Migration[5.2]
  def change
    remove_column :resources, :image, :string
  end
end
