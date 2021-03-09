class AddRankToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :rank, :string
    add_index :items, [:rank, :list_id], unique: true
  end
end
