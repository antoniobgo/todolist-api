# frozen_string_literal: true

class Section < ApplicationRecord
  belongs_to :board
  has_many :items, dependent: :destroy

  validates :title, presence: true, length: { maximum: 70 }
end
