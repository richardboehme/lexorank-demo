# frozen_string_literal: true

class AddRankToItems < ActiveRecord::Migration[6.1]
  def change
    change_table :items, bulk: true do |t|
      t.string :rank
      t.index [:rank, :list_id], unique: true
    end
  end
end
