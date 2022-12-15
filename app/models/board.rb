class Board < ApplicationRecord
  has_many :sections
  belongs_to :user

  validates :title, presence: true
end
