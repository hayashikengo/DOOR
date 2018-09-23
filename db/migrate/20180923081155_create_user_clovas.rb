class CreateUserClovas < ActiveRecord::Migration[5.2]
  def change
    create_table :user_clovas do |t|
      t.references :user, foreign_key: true
      t.references :clova, foreign_key: true

      t.timestamps
    end
  end
end
