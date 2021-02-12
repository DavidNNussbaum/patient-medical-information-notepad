# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20210212000330) do

  create_table "comments", force: :cascade do |t|
    t.text    "identifier"
    t.text    "note"
    t.text    "items_to_discuss"
    t.text    "questions"
    t.integer "patient_id"
  end

  create_table "histories", force: :cascade do |t|
    t.text    "diagnoses"
    t.text    "medications"
    t.text    "allergies"
    t.text    "current_treatments"
    t.text    "surgeries"
    t.text    "immunizations_with_dates"
    t.integer "patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

  create_table "subjectives", force: :cascade do |t|
    t.text    "location"
    t.text    "observed_changes"
    t.text    "sensation_changes"
    t.string  "scale_1_to_10"
    t.text    "length_of_time"
    t.integer "patient_id"
  end

end
