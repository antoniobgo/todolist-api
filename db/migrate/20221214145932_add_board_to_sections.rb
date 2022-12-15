# frozen_string_literal: true

class AddBoardToSections < ActiveRecord::Migration[7.0]
  def change
    add_reference :sections, :board, null: false, foreign_key: true
  end
end
