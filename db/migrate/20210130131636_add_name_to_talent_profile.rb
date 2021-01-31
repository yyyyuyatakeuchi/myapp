class AddNameToTalentProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :talent_profiles, :name, :string, null: false, default: false
  end
end
