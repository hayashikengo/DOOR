class CreatePatrolUserCities < ActiveRecord::Migration[5.2]
  def change
    create_table :patrol_user_cities do |t|
      t.references :user, foreign_key: true
      t.references :city

      t.timestamps
    end
  end
end
