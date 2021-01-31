class ChangeDefaultToTalentProfile < ActiveRecord::Migration[6.1]
  def change
    change_column :talent_profiles, :history, :string, default: ""
    change_column :talent_profiles, :belongs, :string, default: ""
    change_column :talent_profiles, :character, :text, default: ""
    change_column :talent_profiles, :character, :text, default: ""
    change_column_default :talent_profiles, :name, from: false, to: "Guest"
  end
end
