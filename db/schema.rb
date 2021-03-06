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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20151028192057) do

  create_table "box_attributes", :force => true do |t|
    t.integer  "box_id",     :null => false
    t.text     "name",       :null => false
    t.text     "value",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "box_attributes", ["box_id"], :name => "index_box_attributes_on_box_id"

  create_table "boxes", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "serial"
    t.string   "model"
    t.date     "purchase_date"
    t.string   "vendor"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "cloud_accounts", :force => true do |t|
    t.string   "name"
    t.string   "charge_index"
    t.string   "customer_type"
    t.string   "organization"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "cloud_environments", :force => true do |t|
    t.string   "name"
    t.string   "host_network"
    t.string   "host_gateway"
    t.string   "host_vlan"
    t.string   "container_network"
    t.string   "container_vlan"
    t.string   "container_gateway"
    t.string   "overlay_network"
    t.string   "overlay_vlan"
    t.string   "overlay_gateway"
    t.string   "storage_network"
    t.string   "storage_vlan"
    t.string   "storage_gateway"
    t.string   "swift_network"
    t.string   "swift_vlan"
    t.string   "swift_gateway"
    t.string   "internal_vip"
    t.string   "external_vip"
    t.text     "notes"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "cloud_environments_attributes", :force => true do |t|
    t.integer  "cloud_environments_id", :null => false
    t.text     "name",                  :null => false
    t.text     "value",                 :null => false
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "cloud_environments_attributes", ["cloud_environments_id"], :name => "index_cloud_environments_attributes_on_cloud_environments_id"

  create_table "cloud_user_attributes", :force => true do |t|
    t.integer  "cloud_user_id", :null => false
    t.text     "name",          :null => false
    t.text     "value",         :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "cloud_user_attributes", ["cloud_user_id"], :name => "index_cloud_user_attributes_on_cloud_user_id"

  create_table "cloud_users", :force => true do |t|
    t.string   "name"
    t.boolean  "admin",             :default => false
    t.integer  "contact_id"
    t.datetime "sla_accept_date"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "cloud_accounts_id"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "contacts", ["email"], :name => "index_contacts_on_email", :unique => true

  create_table "host_attributes", :force => true do |t|
    t.integer  "host_id",    :null => false
    t.text     "name",       :null => false
    t.text     "value",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "host_attributes", ["host_id"], :name => "index_host_attributes_on_host_id"

  create_table "hosts", :force => true do |t|
    t.string   "name"
    t.string   "kernel"
    t.string   "operating_system"
    t.string   "os_release"
    t.string   "ip"
    t.string   "nic1_macaddress"
    t.string   "ipmi_macaddress"
    t.string   "ipmi_ipaddress"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "serial"
    t.string   "memory"
    t.string   "cloud_environment"
    t.string   "location"
    t.string   "role"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], :name => "taggings_idx", :unique => true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "taggings_count", :default => 0
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "roles"
    t.string   "roles_mask"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
