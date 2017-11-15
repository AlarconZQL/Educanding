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

ActiveRecord::Schema.define(version: 20171115065231) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_comment_votes", force: :cascade do |t|
    t.boolean "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "answer_comment_id"
  end

  create_table "answer_comments", force: :cascade do |t|
    t.string "contenido"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "answer_id"
    t.integer "user_id"
  end

  create_table "answer_votes", force: :cascade do |t|
    t.boolean "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "answer_id"
  end

  create_table "answers", force: :cascade do |t|
    t.string "contenido"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_id"
    t.integer "user_id"
  end

  create_table "directions", force: :cascade do |t|
    t.string "ciudad"
    t.string "calle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faculties", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "direction_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levels", force: :cascade do |t|
    t.string "nombre"
    t.integer "puntos"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_comment_votes", force: :cascade do |t|
    t.boolean "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "question_comment_id"
  end

  create_table "question_comments", force: :cascade do |t|
    t.string "contenido"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_id"
    t.integer "user_id"
  end

  create_table "question_labels", force: :cascade do |t|
    t.integer "question_id"
    t.integer "label_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_votes", force: :cascade do |t|
    t.boolean "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "contenido"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "faculty_id"
    t.integer "num_visitas"
    t.integer "mejor_respuesta"
  end

  create_table "users", force: :cascade do |t|
    t.string "nombre"
    t.string "apellido"
    t.string "mail"
    t.integer "puntos"
    t.string "pass"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level_id"
    t.integer "faculty_id"
  end

end
