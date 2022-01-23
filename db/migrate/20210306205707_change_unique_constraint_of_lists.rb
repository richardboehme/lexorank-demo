# frozen_string_literal: true

class ChangeUniqueConstraintOfLists < ActiveRecord::Migration[6.1]
  def change
    change_table :lists, bulk: true do |t|
      t.remove_index :rank
      t.index [:rank, :session_id], unique: true
    end
  end
end
