# frozen_string_literal: true

class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists, options: 'COLLATE utf8mb4_bin' do |t|
      t.string :name
      t.timestamps
    end
  end
end
