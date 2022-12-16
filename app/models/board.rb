class Board < ApplicationRecord
  has_many :sections, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { maximum: 70 }
end
