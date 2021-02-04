class RemoveNameFromTalentProfiles < ActiveRecord::Migration[6.1]
  def change
    remove_column :talent_profiles, :name, :string
  end
end
