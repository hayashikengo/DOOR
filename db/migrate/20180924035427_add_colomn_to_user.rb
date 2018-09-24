class AddColomnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :displayName, :string
    add_column :users, :pictureUrl, :string
  end
end
