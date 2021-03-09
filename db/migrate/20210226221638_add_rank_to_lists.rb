class AddRankToLists < ActiveRecord::Migration[6.1]
  def change
    add_column :lists, :rank, :string
    add_index :lists, :rank, unique: true
  end
end
