class ChangeToUserClova < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_clovas, :line_user_id
  end
  def down
    add_column :user_clovas, :line_user_id, :string, uniqueness: true
  end
end
