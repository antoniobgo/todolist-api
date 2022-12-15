# frozen_string_literal: true

class AddSectionToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :section, null: false, foreign_key: true
  end
end
