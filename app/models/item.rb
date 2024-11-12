# frozen_string_literal: true

require "lexorank/rankable"
class Item < ApplicationRecord
  belongs_to :list

  rank!(group_by: :list)

  validates :name, presence: true
end
