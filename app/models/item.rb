require 'lexorank/rankable'
class Item < ApplicationRecord
  belongs_to :list

  rank!(group_by: :list)

  validates_presence_of :name
end
