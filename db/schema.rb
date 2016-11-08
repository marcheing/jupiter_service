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

ActiveRecord::Schema.define(version: 20161108114734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_evaluations", force: :cascade do |t|
    t.string   "method"
    t.string   "criterion"
    t.string   "rec"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_evaluations_on_course_id", using: :btree
  end

  create_table "course_workloads", force: :cascade do |t|
    t.integer  "class_credits"
    t.integer  "work_credits"
    t.integer  "total"
    t.integer  "course_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["course_id"], name: "index_course_workloads_on_course_id", using: :btree
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "alt_name"
    t.string   "faculty"
    t.string   "department"
    t.string   "period"
    t.date     "activation_date"
    t.text     "goals"
    t.text     "syllabus"
    t.text     "short_syllabus"
    t.text     "evaluation"
    t.text     "bibliography"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "courses_professors", force: :cascade do |t|
    t.integer "course_id",    null: false
    t.integer "professor_id", null: false
  end

  create_table "cycles", force: :cascade do |t|
    t.string   "name"
    t.string   "period"
    t.integer  "codcur"
    t.integer  "codhab"
    t.date     "start_date"
    t.string   "ideal_duration"
    t.string   "minimum_duration"
    t.string   "maximum_duration"
    t.text     "specific_information"
    t.text     "observations"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "didactic_activities", force: :cascade do |t|
    t.integer  "workload_hours"
    t.string   "activity_type"
    t.integer  "professor_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "offer_id"
    t.index ["offer_id"], name: "index_didactic_activities_on_offer_id", using: :btree
    t.index ["professor_id"], name: "index_didactic_activities_on_professor_id", using: :btree
  end

  create_table "faculties", force: :cascade do |t|
    t.integer  "code",       null: false
    t.string   "name"
    t.string   "campus"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ideal_terms", force: :cascade do |t|
    t.integer  "course_id",  null: false
    t.integer  "cycle_id",   null: false
    t.string   "category",   null: false
    t.string   "term",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_ideal_terms_on_course_id", using: :btree
    t.index ["cycle_id"], name: "index_ideal_terms_on_cycle_id", using: :btree
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "course_id",    null: false
    t.date     "start_date"
    t.date     "end_date"
    t.string   "class_type"
    t.string   "class_code"
    t.text     "observations"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id"], name: "index_offers_on_course_id", using: :btree
  end

  create_table "professors", force: :cascade do |t|
    t.integer  "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.string   "day"
    t.string   "start_time"
    t.string   "end_time"
    t.integer  "professor_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "offer_id"
    t.index ["offer_id"], name: "index_schedules_on_offer_id", using: :btree
    t.index ["professor_id"], name: "index_schedules_on_professor_id", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string   "kind"
    t.string   "assigned_to"
    t.integer  "vacancy"
    t.integer  "subscribed"
    t.integer  "pending"
    t.integer  "enrolled"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "offer_id"
    t.index ["offer_id"], name: "index_subscriptions_on_offer_id", using: :btree
  end

  create_table "workloads", force: :cascade do |t|
    t.text     "mandatory"
    t.text     "optional"
    t.text     "elective"
    t.text     "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "cycle_id"
    t.index ["cycle_id"], name: "index_workloads_on_cycle_id", using: :btree
  end

end
