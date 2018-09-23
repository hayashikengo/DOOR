class ChangeColumnToClova < ActiveRecord::Migration[5.2]
  def change
    add_column :clovas, :line_user_id, :string
  end
  def down
    remove_column :clovas, :line_user_id, :string
  end
end
