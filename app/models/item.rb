# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :section

  validates :title, presence: true
end
