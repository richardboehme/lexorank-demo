class ChangeUniqueConstraintOfLists < ActiveRecord::Migration[6.1]
  def change
    remove_index :lists, :rank
    add_index :lists, [:rank, :session_id], unique: true
  end
end
