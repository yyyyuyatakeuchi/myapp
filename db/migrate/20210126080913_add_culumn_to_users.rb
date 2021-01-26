class AddCulumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :isTalent, :boolean, null: false, default: false
  end
end
