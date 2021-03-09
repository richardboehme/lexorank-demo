class Session < ActiveRecord::SessionStore::Session
  has_many :lists, dependent: :destroy
end
