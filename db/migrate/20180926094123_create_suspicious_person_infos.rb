class CreateSuspiciousPersonInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :suspicious_person_infos do |t|
      t.datetime :published_at
      t.string :text
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
