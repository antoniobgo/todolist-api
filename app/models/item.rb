# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :section

  validates :title, presence: true, length: { maximum: 70 }
  validates :description, length: { maximum: 200 }
end
