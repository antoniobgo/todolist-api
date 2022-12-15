# frozen_string_literal: true

class Section < ApplicationRecord
  belongs_to :board
  has_many :items
end
