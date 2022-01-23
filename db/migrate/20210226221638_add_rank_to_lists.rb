# frozen_string_literal: true

class AddRankToLists < ActiveRecord::Migration[6.1]
  def change
    change_table :lists, bulk: true do |t|
      t.string :rank
      t.index :rank, unique: true
    end
  end
end
