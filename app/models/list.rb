# frozen_string_literal: true

require 'lexorank/rankable'
class List < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :session

  rank!(group_by: :session)

  validates :name, presence: true
end
