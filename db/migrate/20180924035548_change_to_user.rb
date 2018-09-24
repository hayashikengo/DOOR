class ChangeToUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :name
  end
  def down
    add_column :users, :name, :string
  end
end
