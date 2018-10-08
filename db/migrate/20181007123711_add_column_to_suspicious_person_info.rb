class AddColumnToSuspiciousPersonInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :suspicious_person_infos, :source_url, :string
  end
end
