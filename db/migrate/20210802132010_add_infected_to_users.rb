class AddInfectedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :infected, :boolean, default: false
  end
end
