# frozen_string_literal: true

class AddSessionToList < ActiveRecord::Migration[6.1]
  def change
    add_reference :lists, :session, null: false, foreign_key: true # rubocop:disable Rails/NotNullColumn
  end
end
