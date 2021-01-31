class CreateTalentProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :talent_profiles do |t|
      t.string :history
      t.string :belongs
      t.text :character
      t.text :free_write
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
