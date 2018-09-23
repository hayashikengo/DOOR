class CreateClovas < ActiveRecord::Migration[5.2]
  def change
    create_table :clovas do |t|
      t.string :name

      t.timestamps
    end
  end
end
