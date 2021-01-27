class DdColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :address, :string
    add_column :users, :isTalent, :boolean
    change_column_null :users, :isTalent, false, false
    change_column_default :users, :isTalent, from: nil, to: false
  end
end
