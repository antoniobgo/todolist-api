# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_221_215_152_823) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'boards', force: :cascade do |t|
    t.string 'title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id', null: false
    t.index ['user_id'], name: 'index_boards_on_user_id'
  end

  create_table 'items', force: :cascade do |t|
    t.string 'title'
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'section_id', null: false
    t.index ['section_id'], name: 'index_items_on_section_id'
  end

  create_table 'sections', force: :cascade do |t|
    t.string 'title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'board_id', null: false
    t.index ['board_id'], name: 'index_sections_on_board_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'password_digest'
  end

  add_foreign_key 'boards', 'users'
  add_foreign_key 'items', 'sections'
  add_foreign_key 'sections', 'boards'
end
