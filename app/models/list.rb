require 'lexorank/rankable'
class List < ApplicationRecord
  has_many :items
  belongs_to :session

  rank!(group_by: :session)

  validates_presence_of :name
end
