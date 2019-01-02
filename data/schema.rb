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

ActiveRecord::Schema.define(version: 20181221135354) do

  create_table "account_events", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", default: 0, null: false
    t.enum "type", limit: ["card_activated", "sec_card_activated", "card_shipped", "profile_changed", "app_completed", "failed_id", "neg_bal", "bal", "acct_funded", "billpay", "billpay_check_cleared", "billpay_check_mailed", "billpay_request_made", "billpay_request_returned", "sched_billpay_fail", "pin_change", "addr_change", "card_status_change", "account_status_change", "card_returned"]
    t.decimal "balance", precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "event_at", null: false
    t.string "card_status", default: "", null: false
    t.integer "card_id", default: 0, null: false
    t.index ["user_id"], name: "index_account_events_on_user_id"
  end

  create_table "account_savings_goal_targets", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.boolean "target_reached_shown", default: false, null: false
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_savings_goal_id", null: false
    t.index ["account_savings_goal_id"], name: "index_account_savings_goal_targets_on_account_savings_goal_id"
  end

  create_table "account_savings_goals", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "name", null: false
    t.decimal "balance", precision: 12, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_bank_account_id", null: false
    t.index ["user_bank_account_id"], name: "index_account_savings_goals_on_user_bank_account_id"
  end

  create_table "ach_accounts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.string "bank_name", default: "", null: false
    t.string "routing_number", default: "0", null: false
    t.string "account_number", default: "0", null: false
    t.integer "external_id", default: 0, null: false
    t.datetime "verified_at"
    t.enum "status", limit: ["unverified", "verified", "failed"], default: "unverified", null: false
    t.string "subtype", default: "checking", null: false
    t.boolean "is_deleted", default: false, null: false
    t.integer "challenge_deposit_external_id", default: 0, null: false
    t.integer "verification_attempts", default: 0, null: false
    t.integer "business_hold_days", default: 4, null: false
    t.string "plaid_access_token", default: "", null: false
    t.enum "proof_of_ownership", limit: ["none", "documentation", "authentication", "other"], default: "none", null: false
    t.string "bank_type"
    t.enum "plaid_permissions", limit: ["auth", "info", "connect"]
    t.string "account_name", default: ""
    t.enum "type", limit: ["depository", "credit", "loan", "mortgage", "brokerage", "other"], default: "depository", null: false
    t.decimal "balance", precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "balance_updated_at"
    t.enum "connection_status", limit: ["good", "bad", "not_connected"], default: "not_connected"
    t.enum "transfer_direction", limit: ["both", "in", "out", "none"], default: "none", null: false
    t.boolean "address_matched", default: false, null: false
    t.boolean "name_matched", default: false, null: false
    t.string "bank_url"
    t.datetime "last_identified_dd"
    t.index ["plaid_access_token"], name: "index_ach_accounts_on_plaid_access_token"
    t.index ["routing_number", "account_number"], name: "index_ach_accounts_on_routing_number_and_account_number"
    t.index ["user_id", "routing_number", "account_number"], name: "index_ach_accounts_on_user_routing_account_number", unique: true
    t.index ["user_id"], name: "index_ach_accounts_on_user_id"
  end

  create_table "ach_transfers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "ach_account_id", null: false
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.enum "type", limit: ["debit", "credit"], default: "debit", null: false
    t.boolean "verification", default: false, null: false
    t.enum "status", limit: ["queued", "processing", "submitted", "processed", "failed", "cancelled"], default: "queued", null: false
    t.datetime "queued_at", null: false
    t.datetime "submitted_at"
    t.integer "failure_code", default: 0, null: false
    t.integer "external_id", default: 0, null: false
    t.string "return_code", default: "", null: false
    t.integer "payment_id", default: 0, null: false
    t.integer "galileo_hold_days", default: 0, null: false
    t.datetime "external_debit_confirmed_at"
    t.string "external_debit_id"
    t.index ["ach_account_id"], name: "index_ach_transfers_on_ach_account_id"
    t.index ["external_id"], name: "index_ach_transfers_on_external_id"
    t.index ["status"], name: "index_ach_transfers_on_status"
  end

  create_table "active_admin_comments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.string "resource_id", default: "", null: false
    t.string "resource_type", default: "", null: false
    t.integer "author_id"
    t.string "author_type"
    t.text "body"
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "namespace"
    t.integer "external_id", default: 0, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_id"], name: "index_active_admin_comments_on_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id"
  end

  create_table "admin_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "permissions", default: 0
    t.datetime "password_changed_at"
    t.string "unique_session_id", limit: 20
    t.datetime "last_activity_at"
    t.datetime "expired_at"
    t.integer "failed_attempts", default: 0
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["expired_at"], name: "index_admin_users_on_expired_at"
    t.index ["last_activity_at"], name: "index_admin_users_on_last_activity_at"
    t.index ["password_changed_at"], name: "index_admin_users_on_password_changed_at"
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "alert_authorization_events", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id"
    t.integer "merchant_id"
    t.string "type", default: "", null: false
    t.integer "prod_id", default: 0, null: false
    t.integer "prog_id", default: 0, null: false
    t.bigint "prn", default: 0, null: false
    t.string "merch_name"
    t.string "merch_num"
    t.string "mcc", default: "", null: false
    t.string "merch_loc"
    t.string "tran_type", default: "", null: false
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.integer "cur_code", default: 0, null: false
    t.decimal "balance", precision: 12, scale: 2, default: "0.0", null: false
    t.string "tran_id", default: "", null: false
    t.datetime "tran_timestamp", null: false
    t.integer "account_id", default: 0, null: false
    t.bigint "card_id", default: 0, null: false
    t.enum "status", limit: ["failed", "processed"], default: "failed", null: false
    t.string "source_id", default: "", null: false
    t.string "auth_id", default: "", null: false
    t.index ["user_id", "type", "source_id"], name: "user_id"
    t.index ["user_id", "type", "tran_id"], name: "index_alert_authorization_events_on_user_id_and_type_and_tran_id", unique: true
  end

  create_table "alert_transaction_events", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id"
    t.integer "merchant_id"
    t.string "type", default: "", null: false
    t.integer "prod_id", default: 0, null: false
    t.integer "prog_id", default: 0, null: false
    t.bigint "prn", default: 0, null: false
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "balance", precision: 12, scale: 2, default: "0.0", null: false
    t.string "tran_id", default: "", null: false
    t.datetime "timestamp", null: false
    t.integer "account_id", default: 0, null: false
    t.string "merch_num", default: "", null: false
    t.string "source_id", default: "", null: false
    t.enum "status", limit: ["failed", "processed"], default: "failed", null: false
    t.string "description", default: "", null: false
    t.string "act_type", default: ""
    t.string "otype", default: ""
    t.datetime "effective_dt"
    t.index ["user_id", "type", "tran_id"], name: "index_alert_transaction_events_on_user_id_and_type_and_tran_id", unique: true
  end

  create_table "all_deals", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.integer "deal_id", default: 0, null: false
    t.boolean "custom", default: false, null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.string "name", default: "", null: false
    t.integer "merchant_id", default: 0, null: false
  end

  create_table "api_providers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "name", default: "", null: false
    t.string "key", default: "", null: false
    t.binary "secret", null: false
    t.binary "secret_key", null: false
    t.binary "secret_iv", null: false
    t.index ["name"], name: "index_api_providers_on_name"
  end

  create_table "auto_transfer_rules", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", default: 0, null: false
    t.integer "ach_account_id", default: 0
    t.enum "type", limit: ["auto_monthly", "auto_weekly", "threshold_top_up", "threshold_amount"], default: "auto_monthly", null: false
    t.decimal "trigger", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "triggered_at"
    t.integer "external_card_id"
    t.index ["ach_account_id"], name: "index_ach_transfer_rules_on_ach_account_id"
    t.index ["external_card_id"], name: "index_auto_transfer_rules_on_external_card_id"
    t.index ["user_id"], name: "index_ach_transfer_rules_on_user_id"
  end

  create_table "beta_signups", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "email"
    t.string "phone_number"
    t.string "landing_page_url_slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "encrypted_password"
    t.decimal "zip_code", precision: 10
    t.string "user_agent"
  end

  create_table "blocked_addresses", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "address", default: "", null: false
    t.string "address2", null: false
    t.string "city", null: false
    t.string "state_code", limit: 2, null: false
    t.decimal "zip_code", precision: 5, null: false
    t.index ["address"], name: "index_blocked_addresses_on_address"
    t.index ["city"], name: "index_blocked_addresses_on_city"
    t.index ["state_code"], name: "index_blocked_addresses_on_state_code"
    t.index ["zip_code"], name: "index_blocked_addresses_on_zip_code"
  end

  create_table "blocked_email_providers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "domain_name", default: "", null: false
    t.boolean "blocked", default: true, null: false
    t.index ["blocked"], name: "index_blocked_email_providers_on_blocked"
    t.index ["domain_name"], name: "index_blocked_email_providers_on_domain_name"
  end

  create_table "blocked_ips", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "ip_address", default: "", null: false
    t.boolean "blocked", default: true, null: false
    t.index ["blocked"], name: "index_blocked_ips_on_blocked"
    t.index ["ip_address"], name: "index_blocked_ips_on_ip_address"
  end

  create_table "bot_ci_questions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "question", limit: 4096, null: false
    t.string "correct_intent", null: false
  end

  create_table "bot_ci_run_intent_tests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer "bot_ci_runs_id"
    t.string "name"
    t.float "threshold", limit: 24
    t.integer "exchanges_run"
    t.integer "exchanges_passed"
    t.boolean "passing"
    t.index ["bot_ci_runs_id"], name: "index_bot_ci_run_intent_tests_on_bot_ci_runs_id"
  end

  create_table "bot_ci_run_user_exchanges", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "bot_ci_run_id", null: false
    t.integer "bot_ci_question_id", null: false
    t.string "run_intent", null: false
    t.float "confidence", limit: 24, null: false
    t.string "correct_intent", null: false
    t.boolean "intent_was_correct", null: false
    t.bigint "bot_ci_run_intent_test_id"
    t.index ["bot_ci_question_id"], name: "bot_ci_run_question_intentions_bot_ci_question_id_fk"
    t.index ["bot_ci_run_id"], name: "bot_ci_run_question_intentions_bot_ci_run_id_fk"
    t.index ["bot_ci_run_intent_test_id"], name: "index_bot_ci_run_user_exchanges_on_bot_ci_run_intent_test_id"
  end

  create_table "bot_ci_runs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.integer "number_of_questions"
    t.integer "number_of_correct_intents", default: 0, null: false
    t.integer "number_of_wrong_intents", default: 0, null: false
    t.string "watson_workspace_id", null: false
    t.string "watson_workspace_name"
    t.boolean "deployable"
  end

  create_table "bulletin_categories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.boolean "enabled", default: false, null: false
    t.enum "name", limit: ["checking", "savings", "widget"], default: "widget", null: false
    t.index ["name"], name: "index_bulletin_categories_on_name", unique: true
  end

  create_table "bulletin_series", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "name", default: "", null: false
    t.integer "cohort_id", default: 1, null: false
    t.integer "bulletin_category_id", null: false
    t.boolean "enabled", default: false, null: false
    t.integer "priority", default: 0, null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.enum "display_type", limit: ["standard", "carousel", "weighted"], default: "standard", null: false
    t.boolean "early_life_cycle", default: false, null: false
    t.index ["bulletin_category_id"], name: "index_bulletin_series_on_bulletin_category_id"
    t.index ["cohort_id"], name: "index_bulletin_series_on_cohort_id"
  end

  create_table "bulletins", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "title", default: "", null: false
    t.string "sub_title", default: "", null: false
    t.string "link_url", default: "", null: false
    t.string "image_url", default: "", null: false
    t.boolean "enabled", default: false, null: false
    t.string "color"
    t.string "button_copy"
    t.integer "bulletin_series_id", null: false
    t.integer "bulletin_series_sequence", default: 0, null: false
    t.string "tracking_name", default: "", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "weight", default: 0, null: false
    t.boolean "use_login_token", default: false
    t.integer "cohort_id"
    t.index ["bulletin_series_id", "bulletin_series_sequence"], name: "bulletin_series_index", unique: true
    t.index ["bulletin_series_id"], name: "index_bulletins_on_bulletin_series_id"
    t.index ["cohort_id"], name: "index_bulletins_on_cohort_id"
  end

  create_table "categories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "mcc", default: 0, null: false
    t.string "description", default: "", null: false
    t.integer "merchant_category_id", null: false
    t.index ["mcc"], name: "index_categories_on_mcc", unique: true
    t.index ["merchant_category_id"], name: "index_categories_on_merchant_category_id"
  end

  create_table "cohort_stage_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
  end

  create_table "cohort_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "cohort_id", null: false
    t.integer "user_id", null: false
    t.index ["cohort_id", "user_id"], name: "index_cohort_users_on_cohort_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_cohort_users_on_user_id"
  end

  create_table "cohorts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "name", default: "", null: false
    t.boolean "internal", default: false, null: false
    t.enum "gender", limit: ["male", "female"]
    t.string "segments"
    t.boolean "not_activated_card", default: false, null: false
    t.boolean "redeemed_a_deal", default: false, null: false
    t.boolean "got_a_custom_deal", default: false, null: false
    t.boolean "recurring_direct_deposit", default: false, null: false
    t.boolean "made_a_purchase", default: false, null: false
    t.boolean "added_funds", default: false, null: false
    t.boolean "not_added_funds", default: false, null: false
    t.boolean "birthday_today", default: false, null: false
    t.boolean "multiple_debit_cards", default: false, null: false
    t.string "age_range"
    t.string "balance_range"
    t.string "days_enrolled_range"
    t.boolean "external_card_expired", default: false, null: false
    t.string "external_card_expiring_in_days_range"
    t.boolean "not_recurring_direct_deposit", default: false, null: false
    t.boolean "active", default: false, null: false
    t.boolean "activated_card", default: false, null: false
    t.boolean "birthday_tomorrow", default: false, null: false
    t.string "ad_campaign_id"
    t.boolean "low_balance", default: false, null: false
    t.boolean "not_made_a_purchase", default: false, null: false
    t.boolean "anniversary", default: false, null: false
    t.integer "custom_deal_id"
    t.integer "redeemed_deal_id"
    t.boolean "unread_support_message", default: false, null: false
    t.boolean "debit_card", default: false, null: false
    t.boolean "card_blocked", default: false, null: false
    t.string "app_version"
    t.enum "device_type", limit: ["ios", "android", "web"]
    t.boolean "bancorp", default: false, null: false
    t.boolean "not_bancorp", default: false, null: false
    t.boolean "manufactured_spender", default: false, null: false
    t.boolean "ever_done_payroll_dd", default: false, null: false
    t.integer "did_payroll_dd_within_days_ago"
    t.boolean "everyone", default: false, null: false
    t.boolean "not_manufactured_spender", default: false, null: false
    t.boolean "employee", default: false, null: false
    t.boolean "open_savings_account", default: false, null: false
    t.boolean "no_open_savings_account", default: false, null: false
    t.boolean "roundups_enabled", default: false, null: false
    t.boolean "roundups_disabled", default: false, null: false
    t.boolean "sent_direct_deposit_form_in_last_30_days", default: false, null: false
    t.boolean "cherry_picked", default: false, null: false
    t.integer "segment_parent_id"
    t.boolean "not_sent_dd_form_in_last_30_days", default: false, null: false
    t.boolean "got_tax_refund_this_year", default: false, null: false
    t.boolean "did_not_get_tax_refund_this_year", default: false, null: false
    t.string "tax_refund_days_ago_range"
    t.boolean "has_ach_account", default: false, null: false
    t.boolean "no_ach_account", default: false, null: false
    t.integer "stated_income"
    t.string "stated_income_ranges"
    t.string "canonical_name", null: false
    t.boolean "needs_enrollment"
    t.boolean "investor"
    t.integer "payroll_dd_threshold"
    t.boolean "socure_score_is_fraud"
    t.string "app_version_greater_than_or_equal_to"
    t.string "app_version_less_than"
    t.boolean "has_employer"
    t.string "state_filter"
    t.index ["canonical_name"], name: "index_cohorts_on_canonical_name", unique: true
    t.index ["custom_deal_id"], name: "index_cohorts_on_custom_deal_id"
    t.index ["name"], name: "index_cohorts_on_name", unique: true
    t.index ["redeemed_deal_id"], name: "index_cohorts_on_redeemed_deal_id"
    t.index ["segment_parent_id"], name: "index_cohorts_on_segment_parent_id"
  end

  create_table "conversation_messages", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "conversation_id", default: 0, null: false
    t.enum "sent_by", limit: ["consumer", "customer_service", "system"], default: "consumer", null: false
    t.text "body", null: false
    t.string "sender_name", default: "", null: false
    t.index ["conversation_id"], name: "index_conversation_messages_on_conversation_id"
  end

  create_table "conversations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.enum "initiated_by", limit: ["consumer", "customer_service", "system"], default: "consumer", null: false
    t.integer "user_id", default: 0, null: false
    t.string "subject", default: "", null: false
    t.boolean "hidden", default: false, null: false
    t.boolean "awaiting_response", default: true, null: false
    t.boolean "has_been_read", default: false, null: false
    t.string "message_id", default: "", null: false
    t.boolean "migrated_to_zendesk", default: false, null: false
    t.string "helpscout_status"
    t.index ["user_id"], name: "index_conversations_on_user_id"
  end

  create_table "cross_sell_partner_offers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cross_sell_partner_id", null: false
    t.string "heading_copy", null: false
    t.text "short_description", null: false
    t.text "long_description", null: false
    t.string "button_copy", null: false
    t.string "offer_link", null: false
    t.string "offer_category", null: false
    t.string "fine_print_title"
    t.text "fine_print_copy"
    t.boolean "active", default: false, null: false
    t.boolean "promoted", default: false, null: false
    t.integer "cohort_id"
  end

  create_table "cross_sell_partners", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
    t.string "brand_color_hex_code", null: false
  end

  create_table "cst_agents", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "name", default: "", null: false
    t.index ["name"], name: "index_cst_agents_on_name"
  end

  create_table "custom_deal_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "deal_id", null: false
    t.integer "user_id", null: false
    t.index ["deal_id", "user_id"], name: "index_custom_deal_users_on_deal_id_and_user_id", unique: true
    t.index ["deal_id"], name: "index_custom_deal_users_on_deal_id"
    t.index ["user_id"], name: "index_custom_deal_users_on_user_id"
  end

  create_table "daily_stats", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "name", default: "", null: false
    t.date "day", null: false
    t.string "category", default: "", null: false
    t.decimal "value", precision: 12, scale: 2, null: false
    t.index ["category", "name", "day"], name: "index_daily_stats_on_category_and_name_and_day", unique: true
  end

  create_table "deal_categories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "deal_id", null: false
    t.integer "category_id", null: false
    t.index ["category_id"], name: "index_deal_categories_on_category_id"
    t.index ["deal_id"], name: "index_deal_categories_on_deal_id"
  end

  create_table "deal_requests", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", default: 0, null: false
    t.string "google_place_reference"
    t.string "transaction_string"
    t.integer "merchant_deal_request_id"
    t.string "merchant_name"
    t.integer "merchant_id"
    t.index ["google_place_reference"], name: "index_deal_requests_on_google_place_reference"
    t.index ["merchant_deal_request_id"], name: "index_deal_requests_on_merchant_deal_request_id"
    t.index ["merchant_id"], name: "index_deal_requests_on_merchant_id"
    t.index ["user_id"], name: "index_deal_requests_on_user_id"
  end

  create_table "deals", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.decimal "purchase_value", precision: 9, scale: 2, null: false
    t.decimal "promotional_value", precision: 9, scale: 2, null: false
    t.integer "merchant_id"
    t.enum "status", limit: ["draft", "submitted", "approved", "hidden", "expired"], null: false
    t.integer "deals_available", default: 0, null: false
    t.boolean "cancelable", default: true, null: false
    t.string "tags", default: "", null: false
    t.datetime "start_date", null: false
    t.enum "funded_by", limit: ["merchant_pre_paid", "merchant_billed", "one_debit"], default: "one_debit", null: false
    t.integer "number_of_days_to_redeem", default: 30, null: false
    t.datetime "end_date", null: false
    t.enum "type", limit: ["free_credit", "buy_now", "loyalty_visit", "loyalty_amount"], default: "free_credit", null: false
    t.decimal "trigger", precision: 12, scale: 2, default: "0.0", null: false
    t.boolean "cash_reward", default: false, null: false
    t.boolean "renewable", default: false, null: false
    t.boolean "promoted", default: false, null: false
    t.boolean "custom", default: false, null: false
    t.boolean "assigned_by_user_event", default: false, null: false
    t.string "custom_user_event"
    t.boolean "personal", default: false, null: false
    t.enum "personal_user_event", limit: ["onboarded", "activated"]
    t.boolean "funded", default: false, null: false
    t.enum "onboarding_offer_location", limit: ["top_right", "top_left", "bottom_right", "bottom_left"]
    t.boolean "hide_banner", default: false, null: false
    t.integer "cohort_id"
    t.boolean "manufactured_spender", default: false, null: false
    t.boolean "category_reward", default: false, null: false
    t.integer "merchant_category_id"
    t.index ["cohort_id"], name: "index_deals_on_cohort_id"
    t.index ["custom_user_event"], name: "index_deals_on_user_event"
    t.index ["merchant_category_id"], name: "index_deals_on_merchant_category_id"
    t.index ["merchant_id"], name: "deals_merchant_id_fk"
    t.index ["onboarding_offer_location"], name: "index_deals_on_onboarding_offer_location", unique: true
    t.index ["status", "deals_available"], name: "index_deals_on_status_and_deals_available"
  end

  create_table "delayed_jobs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.integer "priority", default: 0
    t.integer "attempts", default: 0
    t.text "handler", limit: 16777215
    t.text "last_error", limit: 16777215
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["locked_by"], name: "index_delayed_jobs_on_locked_by"
    t.index ["queue", "priority", "run_at"], name: "index_delayed_jobs_on_queue_and_priority_and_run_at"
    t.index ["run_at", "priority"], name: "index_delayed_jobs_on_run_at_and_priority"
    t.index ["user_id"], name: "index_delayed_jobs_on_user_id"
  end

  create_table "email_results", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "sender_id", null: false
    t.string "sender_address", default: "", null: false
    t.integer "recipient_id", null: false
    t.string "recipient_address", default: "", null: false
    t.string "subject", default: "", null: false
    t.text "message", null: false
    t.string "error", default: "", null: false
    t.index ["recipient_id"], name: "index_email_results_on_recipient_id"
    t.index ["sender_id"], name: "index_email_results_on_sender_id"
  end

  create_table "emails", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "sender_id", null: false
    t.string "sender_address", default: "", null: false
    t.integer "recipient_id", null: false
    t.string "recipient_address", default: "", null: false
    t.string "subject", default: "", null: false
    t.text "message", null: false
    t.index ["recipient_id"], name: "index_emails_on_recipient_id"
    t.index ["sender_id"], name: "index_emails_on_sender_id"
  end

  create_table "experiments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "landing_page", default: "", null: false
    t.string "intermediary_page", default: "", null: false
    t.string "post_signup_page", default: "", null: false
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fb_tracking_code"
    t.string "google_tracking_code"
    t.text "landing_page_settings"
  end

  create_table "external_api_request_deals", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "external_api_request_id", default: 0, null: false
    t.integer "deal_id", default: 0, null: false
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.index ["deal_id"], name: "index_external_api_request_deals_on_deal_id"
    t.index ["external_api_request_id"], name: "index_external_api_request_deals_on_external_api_request_id"
  end

  create_table "external_api_requests", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id"
    t.integer "user_adjustment_id"
    t.string "method", default: "", null: false
    t.text "request", null: false
    t.text "result", null: false
    t.enum "status", limit: ["requested", "succeeded", "failed", "timeout"], default: "requested"
    t.integer "duration", default: 0, null: false
    t.integer "deal_id"
    t.enum "service", limit: ["galileo", "idology", "vantiv", "experian", "ingo", "cachet", "chex", "plaid", "unbill", "socure", "giact", "ocr", "lean", "socure3"], default: "galileo", null: false
    t.enum "http_method", limit: ["get", "post", "put", "delete"], default: "get", null: false
    t.index ["deal_id"], name: "index_galileo_api_requests_on_deal_id"
    t.index ["user_adjustment_id"], name: "index_transaction_requests_on_user_adjustment_id"
    t.index ["user_id"], name: "index_transaction_requests_on_user_id"
  end

  create_table "external_card_transfers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "external_card_id", null: false
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.enum "status", limit: ["failed", "success", "reversed", "declined"], default: "failed", null: false
    t.integer "payment_transaction_id", default: 0, null: false
    t.bigint "authorization_id", default: 0, null: false
    t.integer "order_id", default: 0, null: false
    t.integer "galileo_transaction_id", default: 0, null: false
    t.integer "fee_transaction_id", default: 0, null: false
    t.integer "fee_request_id", default: 0, null: false
    t.boolean "authorization_pending", default: false, null: false
    t.enum "authorization_method", limit: ["auth", "sale"], default: "sale", null: false
    t.bigint "capture_id", default: 0, null: false
    t.index ["external_card_id"], name: "index_external_card_transfers_on_external_card_id"
    t.index ["order_id"], name: "index_external_card_transfers_on_order_id"
    t.index ["status"], name: "index_external_card_transfers_on_status"
    t.index ["user_id"], name: "index_external_card_transfers_on_user_id"
  end

  create_table "external_cards", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.string "card_token", default: "", null: false
    t.enum "type", limit: ["visa", "mastercard", "amex", "discover"], default: "visa"
    t.integer "last4", default: 0, null: false
    t.integer "expiration_month", default: 0, null: false
    t.integer "expiration_year", default: 0, null: false
    t.boolean "is_deleted", default: false, null: false
    t.string "bank_name", default: "", null: false
    t.integer "bin", default: 0, null: false
    t.enum "proof_of_ownership", limit: ["none", "documentation", "authentication", "other"], default: "none", null: false
    t.boolean "is_blocked", default: false, null: false
    t.boolean "scanned", default: false, null: false
    t.boolean "instant_transfer", default: false, null: false
    t.index ["card_token"], name: "index_external_cards_on_card_token"
    t.index ["user_id"], name: "index_external_cards_on_user_id"
  end

  create_table "external_merchant_blocks", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "external_merchant_id"
    t.string "reason", default: "", null: false
    t.string "blocked_by", default: "", null: false
    t.index ["external_merchant_id"], name: "external_merchant_blocks_external_merchant_id_fk"
  end

  create_table "external_merchants", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "merchant_name", null: false
    t.integer "mcc", default: 0, null: false
    t.boolean "suggest_tip", default: false, null: false
    t.index ["merchant_name"], name: "index_external_merchants_on_merchant_name", unique: true
  end

  create_table "galileo_account_cards", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.integer "unique_program_id", default: 0, null: false
    t.integer "group_id", default: 0, null: false
    t.integer "product_id", default: 0, null: false
    t.integer "galileo_account_id", default: 0, null: false
    t.bigint "prn", default: 0
    t.date "expiration_date", null: false
    t.string "status", default: "", null: false
    t.string "card_id", default: "", null: false
    t.string "card_number", default: "", null: false
    t.string "card_type", default: "", null: false
    t.integer "user_id"
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.boolean "returned", default: false, null: false
    t.datetime "returned_at"
    t.boolean "compromised"
    t.integer "user_bank_account_id"
    t.index ["expiration_date", "status"], name: "index_galileo_account_cards_on_expiration_date_and_status"
    t.index ["galileo_account_id"], name: "index_galileo_account_cards_on_galileo_account_id"
    t.index ["user_bank_account_id"], name: "index_galileo_account_cards_on_user_bank_account_id"
    t.index ["user_id"], name: "index_galileo_account_cards_on_user_id"
  end

  create_table "galileo_ach_responses", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "prn", default: "", null: false
    t.integer "ach_account_id", default: 0, null: false
    t.integer "ach_transaction_id", default: 0, null: false
    t.integer "transaction_id", default: 0, null: false
    t.string "response_code", default: "", null: false
    t.index ["prn"], name: "index_galileo_ach_responses_on_prn"
  end

  create_table "galileo_authorized_transactions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.integer "unique_program_id", default: 0, null: false
    t.integer "galileo_account_id", default: 0, null: false
    t.integer "card_id", default: 0, null: false
    t.datetime "transaction_timestamp", null: false
    t.string "currency_code", default: "", null: false
    t.string "address_verification_response", default: "", null: false
    t.integer "authorization_response", default: 0, null: false
    t.decimal "authorization_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.string "authorization_code", default: "", null: false
    t.string "network_code", default: "", null: false
    t.string "merchant_number", default: "", null: false
    t.string "merchant_name", default: "", null: false
    t.string "merchant_category_code", default: "", null: false
    t.string "transaction_code", default: "", null: false
    t.string "merchant_country_code", default: "", null: false
    t.integer "user_id"
    t.integer "original_auth_id", default: 0, null: false
    t.index ["galileo_account_id", "authorization_code"], name: "index_galileo_authorized_transactions_on_acct_id_and_auth_code"
    t.index ["user_id"], name: "index_galileo_authorized_transactions_on_user_id"
  end

  create_table "galileo_customers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.integer "unique_program_id", default: 0, null: false
    t.datetime "issued_date"
    t.string "cardholder_id", default: "", null: false
    t.string "id_type", default: "", null: false
    t.string "cardholder_first_name", default: "", null: false
    t.string "cardholder_last_name", default: "", null: false
    t.string "address_1", default: "", null: false
    t.string "address_2", default: "", null: false
    t.string "city", default: "", null: false
    t.string "state_code", default: "", null: false
    t.string "zip_code", default: "", null: false
    t.string "primary_phone_number", default: "", null: false
    t.string "secondary_phone_number", default: "", null: false
    t.string "status", default: "", null: false
    t.decimal "current_balance", precision: 12, scale: 2, default: "0.0", null: false
    t.date "created_date"
    t.datetime "negative_balance_date"
    t.decimal "negative_balance_fee_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.boolean "reloadable_indicator", default: true, null: false
    t.integer "galileo_account_id", default: 0, null: false
    t.string "account_type", default: "", null: false
    t.decimal "available_balance", precision: 12, scale: 2, default: "0.0", null: false
    t.string "external_account_number", default: "", null: false
    t.datetime "last_transaction_date"
    t.date "date_of_birth"
    t.integer "bill_cycle_day", default: 0, null: false
    t.string "location_id", default: "", null: false
    t.string "agent_user_id", default: "", null: false
    t.string "cardholder_id_2", default: "", null: false
    t.string "id_type_2", default: "", null: false
    t.string "user_data_1", default: "", null: false
    t.string "user_data_2", default: "", null: false
    t.integer "user_id"
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["galileo_account_id"], name: "index_galileo_customers_on_galileo_account_id"
    t.index ["user_id"], name: "index_galileo_customers_on_user_id"
  end

  create_table "galileo_expired_auths", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "galileo_account_id", null: false
    t.integer "card_id", null: false
    t.bigint "prn", null: false
    t.integer "program_id", null: false
    t.integer "product_id", null: false
    t.integer "transaction_id", null: false
    t.timestamp "authorized_at"
    t.timestamp "expired_at"
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.integer "currency_code", null: false
    t.string "merchant_number", null: false
    t.string "merchant_name", null: false
    t.index ["expired_at"], name: "index_galileo_expired_auths_on_expired_at"
    t.index ["galileo_account_id", "transaction_id"], name: "account_and_transaction_id", unique: true
    t.index ["user_id", "transaction_id"], name: "index_galileo_expired_auths_on_user_id_and_transaction_id"
  end

  create_table "galileo_lookups", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "file", default: "", null: false
    t.string "field_name", default: "", null: false
    t.string "code", default: "", null: false
    t.string "description", default: "", null: false
  end

  create_table "galileo_posted_transactions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.integer "unique_program_id", default: 0, null: false
    t.integer "galileo_account_id", default: 0, null: false
    t.integer "card_id", default: 0, null: false
    t.datetime "transaction_timestamp", null: false
    t.string "transaction_code", default: "", null: false
    t.decimal "transaction_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.string "currency_code", default: "", null: false
    t.string "authorization_code", default: "", null: false
    t.datetime "post_date", null: false
    t.string "network_code", default: "", null: false
    t.string "merchant_number", default: "", null: false
    t.string "merchant_name", default: "", null: false
    t.string "merchant_category_code", default: "", null: false
    t.string "merchant_country_code", default: "", null: false
    t.decimal "interchange_fee_amount", precision: 6, scale: 2, default: "0.0", null: false
    t.string "external_transaction_id", default: "", null: false
    t.string "user_data_1", default: "", null: false
    t.string "user_data_2", default: "", null: false
    t.integer "user_id"
    t.integer "merchant_id"
    t.index ["post_date"], name: "index_galileo_posted_transactions_on_post_date"
    t.index ["transaction_code", "external_transaction_id"], name: "index_galileo_posted_transaction_on_transaction_code"
    t.index ["user_id", "post_date"], name: "index_galileo_posted_transactions_on_user_id_and_post_date"
    t.index ["user_id", "transaction_code", "authorization_code", "network_code"], name: "user_id", unique: true
  end

  create_table "galileo_simulator_ach_accounts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "prn", default: "", null: false
    t.string "name", default: "", null: false
    t.enum "type", limit: ["savings", "checking", "money_market"], default: "checking", null: false
    t.string "routing_number", default: "0", null: false
    t.string "account_number", default: "0", null: false
    t.index ["prn", "routing_number", "account_number"], name: "ach_prn_account_index", unique: true
  end

  create_table "galileo_simulator_adjustment_sources", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
  end

  create_table "galileo_simulator_authorization_sources", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
  end

  create_table "galileo_simulator_authorizations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "accountNo", default: "", null: false
    t.string "details", default: "", null: false
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "timestamp", null: false
    t.string "mcc"
    t.string "merchant_number"
    t.boolean "international", default: false, null: false
    t.index ["accountNo"], name: "index_galileo_simulator_authorizations_on_accountNo"
  end

  create_table "galileo_simulator_bill_payments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "prn", default: "", null: false
    t.integer "biller_id", default: 0, null: false
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "old_balance", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "new_balance", precision: 12, scale: 2, default: "0.0", null: false
    t.date "process_date", null: false
    t.decimal "fee_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "maximum_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.index ["prn"], name: "index_galileo_simulator_bill_payments_on_prn"
  end

  create_table "galileo_simulator_billers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "prn", default: "", null: false
    t.string "account_number", default: "", null: false
    t.string "name", default: "", null: false
    t.string "address", default: "", null: false
    t.string "address2", default: "", null: false
    t.string "city", default: "", null: false
    t.string "state_code", default: "", null: false
    t.string "zip_code", default: "", null: false
    t.string "phone", default: "", null: false
    t.index ["prn"], name: "index_galileo_simulator_billers_on_prn"
  end

  create_table "galileo_simulator_cards", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_number", null: false
    t.string "card_status", default: "Y", null: false
    t.date "expiry_date", null: false
    t.string "card_number", null: false
    t.string "external_card_id"
    t.index ["account_number"], name: "index_galileo_simulator_cards_on_account_number"
  end

  create_table "galileo_simulator_embossed_cards", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_number", null: false
    t.integer "galileo_simulator_card_id", null: false
    t.string "status", default: "Y", null: false
    t.date "expiry_date", null: false
    t.string "cvv", null: false
    t.date "emboss_date", null: false
    t.string "shipping_type"
    t.index ["account_number"], name: "index_galileo_simulator_embossed_cards_on_account_number"
    t.index ["galileo_simulator_card_id"], name: "index_simulator_embossed_card_id"
  end

  create_table "galileo_simulator_holds", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "prn", default: "", null: false
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "expires_at", null: false
    t.string "description", default: "", null: false
    t.integer "payment_id", default: 0, null: false
    t.string "external_id", default: "", null: false
    t.boolean "expired", default: false, null: false
    t.index ["prn"], name: "index_galileo_simulator_holds_on_prn"
  end

  create_table "galileo_simulator_ledger_transactions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "account_number", null: false
    t.string "ach_trans_id", default: "", null: false
    t.string "act_type", default: "", null: false
    t.string "act_type_description", default: "", null: false
    t.decimal "amount", precision: 12, scale: 2
    t.string "arn", default: "", null: false
    t.decimal "calculated_balance", precision: 12, scale: 2
    t.string "deny_code", default: "", null: false
    t.string "details", default: "", null: false
    t.integer "disputable", null: false
    t.string "external_trans_id", default: "", null: false
    t.integer "is_savings", null: false
    t.string "merchant_id", default: "", null: false
    t.datetime "post_ts", null: false
    t.string "source_id", default: "", null: false
    t.string "trans_code", default: "", null: false
    t.string "trans_type", default: "", null: false
    t.string "type_description", default: "", null: false
  end

  create_table "galileo_simulator_notes", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "accountNo", default: "", null: false
    t.string "agent", default: "", null: false
    t.text "note"
    t.string "sticky", default: "", null: false
    t.index ["accountNo"], name: "index_galileo_simulator_notes_on_accountNo"
  end

  create_table "galileo_simulator_payment_sources", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
  end

  create_table "galileo_simulator_transactions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "accountNo", default: "", null: false
    t.string "act_type", default: "", null: false
    t.datetime "post_ts", null: false
    t.decimal "amt", precision: 12, scale: 2, default: "0.0", null: false
    t.string "details", default: "", null: false
    t.string "description", default: "", null: false
    t.string "source_id", default: "", null: false
    t.string "bal_id", default: "", null: false
    t.datetime "auth_ts", null: false
    t.string "trans_code", default: "", null: false
    t.string "transaction_id"
    t.string "mcc"
    t.string "merchant_number"
    t.integer "ach_account_id", default: 0, null: false
    t.string "terminal_id", default: "", null: false
    t.string "external_transaction_id", default: "", null: false
    t.integer "original_auth_id", default: 0, null: false
    t.index ["accountNo"], name: "index_galileo_simulator_transactions_on_accountNo"
    t.index ["transaction_id"], name: "index_galileo_simulator_transactions_on_transaction_id", unique: true
  end

  create_table "galileo_simulator_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "prn", default: "", null: false
    t.decimal "available_balance", precision: 12, scale: 2, default: "0.0", null: false
    t.integer "account_id", default: 0, null: false
    t.decimal "social_security_number", precision: 9, default: "0", null: false
    t.integer "product_id", default: 5048, null: false
    t.datetime "pause_fraud_rules_start_date"
    t.datetime "pause_fraud_rules_end_date"
    t.decimal "credit_limit", precision: 12, scale: 2, default: "0.0", null: false
    t.index ["prn"], name: "index_galileo_simulator_users_on_prn"
  end

  create_table "generic_in_app_messages", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.boolean "response_required", default: false, null: false
    t.string "title", null: false
    t.string "text", null: false
    t.string "image_url", null: false
    t.string "button_1_value", null: false
    t.string "button_1_text", null: false
    t.string "button_1_action"
    t.string "button_2_value"
    t.string "button_2_text"
    t.string "button_2_action"
    t.string "button_3_value"
    t.string "button_3_text"
    t.string "button_3_action"
    t.integer "cohort_id"
    t.index ["cohort_id"], name: "index_generic_in_app_messages_on_cohort_id"
  end

  create_table "job_runs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "name", null: false
    t.datetime "start_time", null: false
    t.integer "input_row_count"
    t.datetime "stop_time"
    t.integer "output_row_count"
    t.string "description"
  end

  create_table "jobs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "title", default: "", null: false
    t.text "description", null: false
    t.text "responsibilities", null: false
    t.text "about_you", null: false
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "questions"
    t.string "to_apply", default: "", null: false
    t.text "perks"
    t.string "employment_type"
    t.string "slug", default: "", null: false
    t.boolean "contract", default: false, null: false
    t.boolean "hidden_from_list", default: false, null: false
  end

  create_table "landing_pages", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "experiment_id", default: 0, null: false
    t.string "headline"
    t.string "sub_headline"
    t.string "check1"
    t.string "check2"
    t.string "check3"
    t.string "subject"
    t.string "image_url", default: "", null: false
    t.text "check1_image", null: false
    t.text "check2_image", null: false
    t.text "check3_image", null: false
    t.index ["experiment_id"], name: "index_landing_pages_on_experiment_id"
  end

  create_table "merchant_categories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "merchant_parent_category_id", null: false
    t.string "name", null: false
    t.string "detail_sub_title"
    t.string "card_image_url"
    t.string "card_icon_char"
    t.string "card_image_file_name"
    t.string "card_image_content_type"
    t.integer "card_image_file_size"
    t.datetime "card_image_updated_at"
    t.enum "monthly_transaction_stats", limit: ["number_of_visits", "running_total", "both"]
    t.string "transaction_emoji"
    t.index ["merchant_parent_category_id"], name: "index_merchant_categories_on_merchant_parent_category_id"
    t.index ["name"], name: "index_merchant_categories_on_name", unique: true
  end

  create_table "merchant_deal_requests", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "merchant_name", default: "", null: false
    t.integer "request_count", default: 1, null: false
    t.integer "merchant_id"
    t.index ["merchant_id"], name: "index_merchant_deal_requests_on_merchant_id", unique: true
    t.index ["merchant_name"], name: "index_merchant_deal_requests_on_merchant_name", unique: true
  end

  create_table "merchant_notifications", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "merchant_id", default: 0, null: false
    t.integer "notification_id", default: 0, null: false
    t.integer "type", default: 0, null: false
    t.integer "obj_id", default: 0, null: false
    t.integer "channels", default: 0, null: false
    t.datetime "delivered_at", null: false
    t.string "user_name", default: "", null: false
    t.string "deal_name", default: "", null: false
    t.index ["merchant_id"], name: "index_merchant_notifications_on_merchant_id"
    t.index ["notification_id"], name: "index_merchant_notifications_on_notification_id"
  end

  create_table "merchant_parent_categories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "name", null: false
    t.string "card_icon_char"
    t.string "card_image_url"
    t.string "card_image_file_name"
    t.string "card_image_content_type"
    t.integer "card_image_file_size"
    t.datetime "card_image_updated_at"
    t.index ["name"], name: "index_merchant_parent_categories_on_name", unique: true
  end

  create_table "merchant_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "email", default: "", null: false
    t.bigint "phone", null: false
    t.integer "merchant_id", null: false
    t.string "encrypted_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "authentication_token"
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "invitation_token", limit: 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.index ["authentication_token"], name: "index_merchant_users_on_authentication_token", unique: true
    t.index ["confirmation_token"], name: "index_merchant_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_merchant_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_merchant_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_merchant_users_on_invited_by_id"
    t.index ["merchant_id"], name: "index_merchant_users_on_merchant_id"
    t.index ["reset_password_token"], name: "index_merchant_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_merchant_users_on_unlock_token", unique: true
  end

  create_table "merchants", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.bigint "phone", null: false
    t.string "address", default: "", null: false
    t.string "city", default: "", null: false
    t.string "state_code", default: "", null: false
    t.bigint "zip_code", null: false
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.string "address2", default: "", null: false
    t.string "homepage", default: "", null: false
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
    t.string "tag1"
    t.string "tag2"
    t.string "tag3"
    t.integer "price_level", default: 0, null: false
    t.enum "number_locations", limit: ["1", "2-9", "10-49", "50+"], default: "1", null: false
    t.boolean "online", default: false, null: false
    t.integer "merchant_category_id", null: false
    t.string "ios_app_link"
    t.string "android_app_link"
    t.boolean "web_takes_precedence_over_app_link", default: false
    t.string "ios_app_link_text", default: "OPEN APP"
    t.string "android_app_link_text", default: "OPEN APP"
    t.string "web_link", limit: 5000
    t.string "web_link_text", default: "GO TO WEBSITE"
    t.boolean "reverse_deals_on_expiration", default: true, null: false
    t.string "transaction_emoji"
    t.boolean "cash_back", default: false, null: false
    t.boolean "suggest_tip", default: false, null: false
    t.index ["merchant_category_id"], name: "index_merchants_on_merchant_category_id"
    t.index ["name"], name: "index_merchants_on_name", unique: true
  end

  create_table "mids", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "mid", default: "", null: false
    t.string "descriptor", default: "", null: false
    t.integer "merchant_id", null: false
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["merchant_id"], name: "index_mids_on_merchant_id"
  end

  create_table "nearby_configs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "version", default: 1, null: false
    t.integer "maximum_per_day", default: 5, null: false
    t.integer "maximum_per_merchant_per_day", default: 1, null: false
    t.integer "days_in_a_cycle", default: 5, null: false
    t.integer "maximum_per_merchant_per_cycle", default: 1, null: false
    t.integer "start_hour", default: 6, null: false
    t.integer "end_hour", default: 22, null: false
    t.string "title", default: "", null: false
    t.string "message", default: "", null: false
    t.string "link", default: "", null: false
    t.integer "transaction_id", default: 1, null: false
    t.integer "unique_id", default: 1, null: false
    t.boolean "high_priority", default: false, null: false
    t.boolean "send_current_location", default: false, null: false
    t.string "action_name"
    t.integer "action_type_id"
    t.integer "dialog_type_id"
    t.string "share_text"
  end

  create_table "nicknames", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "name", null: false
    t.integer "proper_name_id", null: false
    t.index ["proper_name_id", "name"], name: "index_nicknames_on_proper_name_id_and_name", unique: true
  end

  create_table "notification_settings", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "title", default: "", null: false
    t.string "name", default: "", null: false
    t.string "icon_char", default: "", null: false
  end

  create_table "notification_templates", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "notification_id", default: 0, null: false
    t.enum "channel", limit: ["sms", "email", "push_notification", "feed"], default: "feed", null: false
    t.text "template", limit: 16777215, null: false
    t.index ["notification_id", "channel"], name: "index_notification_templates_on_notification_id_and_channel"
  end

  create_table "notifications", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "type", default: 0, null: false
    t.enum "priority", limit: ["low_priority", "med_priority", "high_priority"], default: "med_priority", null: false
    t.integer "channels", default: 0, null: false
    t.string "title", default: "", null: false
  end

  create_table "old_passwords", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "encrypted_password", default: "", null: false
    t.string "password_salt"
    t.string "password_archivable_type", default: "", null: false
    t.integer "password_archivable_id", null: false
    t.datetime "created_at"
    t.index ["password_archivable_type", "password_archivable_id"], name: "index_password_archivable"
  end

  create_table "partner_user_requests", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "partner_user_id", null: false
    t.string "request_id"
    t.index ["partner_user_id", "request_id"], name: "index_partner_user_requests_on_partner_user_id_and_request_id", unique: true
  end

  create_table "partner_user_webhooks", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "partner_user_id", null: false
    t.string "url", null: false
    t.string "token", default: ""
    t.enum "type", limit: ["chime", "plaid"], default: "chime"
    t.index ["partner_user_id"], name: "index_partner_user_webhooks_on_partner_user_id"
    t.index ["user_id"], name: "index_partner_user_webhooks_on_user_id"
  end

  create_table "partner_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_key", null: false
    t.string "api_secret"
    t.index ["api_key"], name: "index_partner_users_on_api_key", unique: true
  end

  create_table "partnerships", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "name", null: false
    t.string "token", null: false
    t.decimal "roundup_bonus", precision: 3, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_partnerships_on_name", unique: true
    t.index ["token"], name: "index_partnerships_on_token", unique: true
  end

  create_table "pay_friends", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.integer "sender_id", null: false
    t.integer "receiver_id"
    t.enum "status", limit: ["expired", "cancelled", "pending", "succeeded", "failed", "reversed"], default: "pending", null: false
    t.string "memo"
    t.string "receiver_identifier", null: false
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.integer "sender_adjustment_id"
    t.integer "receiver_adjustment_id"
    t.integer "user_contact_transfer_id"
    t.string "token"
    t.string "receiver_confirmation_token"
    t.timestamp "expires_at"
    t.integer "lock_version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_adjustment_id"], name: "index_pay_friends_on_receiver_adjustment_id"
    t.index ["receiver_id"], name: "index_pay_friends_on_receiver_id"
    t.index ["receiver_identifier"], name: "index_pay_friends_on_receiver_identifier"
    t.index ["sender_adjustment_id"], name: "index_pay_friends_on_sender_adjustment_id"
    t.index ["sender_id"], name: "index_pay_friends_on_sender_id"
    t.index ["token"], name: "index_pay_friends_on_token"
    t.index ["user_contact_transfer_id"], name: "index_pay_friends_on_user_contact_transfer_id"
  end

  create_table "personal_deal_configs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.enum "personal_user_event", limit: ["onboarded", "activated"], null: false
    t.integer "days_to_expire", null: false
    t.integer "cohort_id", default: 1, null: false
    t.index ["cohort_id"], name: "index_personal_deal_configs_on_cohort_id"
    t.index ["personal_user_event"], name: "index_personal_deal_configs_on_personal_user_event", unique: true
  end

  create_table "proper_names", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_proper_names_on_name", unique: true
  end

  create_table "properties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "var", null: false
    t.text "value"
    t.string "target_type", null: false
    t.bigint "target_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["target_type", "target_id", "var"], name: "index_properties_on_target_type_and_target_id_and_var", unique: true
    t.index ["target_type", "target_id"], name: "index_properties_on_target_type_and_target_id"
  end

  create_table "provider_scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.decimal "score", precision: 30, scale: 10
    t.string "type"
    t.string "provider"
    t.string "scorable_type"
    t.bigint "scorable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scorable_type", "scorable_id"], name: "index_provider_scores_on_scorable_type_and_scorable_id"
  end

  create_table "realtime_auth_events", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id"
    t.integer "merchant_id"
    t.string "network", default: "", null: false
    t.string "pan", default: "", null: false
    t.bigint "prn", default: 0, null: false
    t.string "proc_code", default: "", null: false
    t.decimal "req_amt", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "final_amt", precision: 12, scale: 2, default: "0.0", null: false
    t.string "trace_number", default: "", null: false
    t.string "mcc", default: "", null: false
    t.boolean "card_present", default: true, null: false
    t.boolean "cardholder_present", default: true, null: false
    t.string "pin_pad_cap", default: "", null: false
    t.string "acq_id"
    t.string "terminal_id"
    t.string "merch_id"
    t.string "merch_name"
    t.string "cvv1_result"
    t.string "cvv2_result"
    t.string "cvv3_result"
    t.string "avs_result"
    t.string "avs_info"
    t.string "pin_result"
    t.string "orig_data_elems"
    t.boolean "recurring_flag", default: false, null: false
    t.decimal "cashback_amt", precision: 12, scale: 2, default: "0.0", null: false
    t.boolean "international", default: false, null: false
    t.integer "trans_curr_code", default: 0, null: false
    t.datetime "trans_date", null: false
    t.string "resp_code", default: "", null: false
    t.string "mti", default: "", null: false
    t.string "account_status"
    t.string "auth_code"
    t.integer "auth_id"
    t.decimal "available_funds", precision: 12, scale: 2, default: "0.0", null: false
    t.string "card_status"
    t.string "expiration_date"
    t.integer "original_auth_id", default: 0, null: false
    t.string "auth_uid", default: "", null: false
    t.string "is_partial_supported", default: "", null: false
    t.integer "risk_score", default: 0, null: false
    t.string "sub_network", default: "", null: false
    t.string "entry_type"
    t.index ["user_id", "auth_id"], name: "user_id"
    t.index ["user_id", "mti", "auth_code"], name: "user_id_2"
  end

  create_table "refer_a_friend_campaigns", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.boolean "enabled", default: true, null: false
    t.string "description", default: "", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.string "heading", default: "", null: false
    t.string "sub_heading", default: "", null: false
    t.text "fine_print", null: false
    t.string "sub_heading_link", default: "", null: false
    t.string "share_heading", default: "", null: false
    t.string "sms_message", default: "", null: false
    t.string "email_subject", default: "", null: false
    t.string "email_message", default: "", null: false
    t.string "copy_message", default: "", null: false
    t.string "facebook_message", default: "", null: false
    t.string "twitter_message", limit: 140, default: "", null: false
    t.decimal "referer_cash_reward", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "friend_cash_reward", precision: 12, scale: 2, default: "0.0", null: false
    t.enum "reward_trigger", limit: ["enrolled", "funded", "payroll_dd"], default: "funded", null: false
    t.integer "cohort_id", null: false
    t.integer "priority", default: 0, null: false
    t.string "icon_char"
    t.string "general_message"
    t.string "dialog_heading"
    t.decimal "funding_amount_threshold", precision: 12, scale: 2, default: "0.0", null: false
    t.enum "reward_type", limit: ["cash", "weekly_roundup_bonus_multiple"], default: "cash", null: false
    t.integer "weekly_roundup_bonus_multiplier", default: 1, null: false
    t.boolean "affiliate", default: false, null: false
    t.datetime "enrolled_by"
    t.decimal "affiliate_payment_for_enrollment", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "affiliate_payment_for_payroll_dd", precision: 12, scale: 2, default: "0.0", null: false
    t.integer "weekly_roundup_bonus_multiple_reward_weeks", default: 1, null: false
    t.string "landing_page_title", default: "", null: false
    t.string "landing_page_copy", default: "", null: false
    t.enum "reward_goes_to", limit: ["none", "referrer", "referee", "both"], default: "referrer", null: false
    t.datetime "funded_by"
    t.datetime "payroll_dd_by"
    t.string "button_copy"
    t.integer "payroll_dd_x_days_after_enroll"
    t.index ["cohort_id"], name: "index_refer_a_friend_campaigns_on_cohort_id"
    t.index ["description"], name: "index_refer_a_friend_campaigns_on_description", unique: true
  end

  create_table "refer_a_friend_campaigns_backkup", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.integer "id", default: 0, null: false
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.enum "name", limit: ["cash", "offer"], default: "cash", null: false
    t.boolean "enabled", default: true, null: false
    t.string "internal_description", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.string "sidebar_copy", null: false
    t.string "sidebar_link"
    t.string "heading", null: false
    t.string "sub_heading", null: false
    t.text "fine_print", null: false
    t.decimal "deal_purchase_value", precision: 12, scale: 2
    t.decimal "deal_promotional_value", precision: 12, scale: 2
    t.datetime "deal_start_date"
    t.datetime "deal_end_date"
    t.integer "deal_number_of_days_to_redeem"
    t.enum "deal_type", limit: ["free_credit", "buy_now", "loyalty_visit", "loyalty_amount"]
    t.decimal "deal_trigger", precision: 12, scale: 2
  end

  create_table "search_results", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.string "search_term"
    t.float "latitude", limit: 24, null: false
    t.float "longitude", limit: 24, null: false
    t.integer "result_count"
    t.index ["user_id"], name: "index_search_results_on_user_id"
  end

  create_table "sidebars", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "title", default: "", null: false
    t.integer "home_sequence", default: 0, null: false
    t.string "home_copy", default: "", null: false
    t.string "home_icon_char", default: "", null: false
    t.integer "transactions_sequence", default: 0, null: false
    t.string "transactions_copy", default: "", null: false
    t.string "transactions_icon_char", default: "", null: false
    t.integer "offers_sequence", default: 0, null: false
    t.string "offers_copy", default: "", null: false
    t.string "offers_icon_char", default: "", null: false
    t.integer "add_funds_sequence", default: 0, null: false
    t.string "add_funds_copy", default: "", null: false
    t.string "add_funds_icon_char", default: "", null: false
    t.integer "free_atm_finder_sequence", default: 0, null: false
    t.string "free_atm_finder_copy", default: "", null: false
    t.string "free_atm_finder_icon_char", default: "", null: false
    t.integer "support_sequence", default: 0, null: false
    t.string "support_copy", default: "", null: false
    t.string "support_icon_char", default: "", null: false
    t.integer "settings_sequence", default: 0, null: false
    t.string "settings_copy", default: "", null: false
    t.string "settings_icon_char", default: "", null: false
    t.integer "refer_a_friend_sequence", default: 0, null: false
    t.string "refer_a_friend_copy", default: "", null: false
    t.string "refer_a_friend_icon_char", default: "", null: false
  end

  create_table "simility_decision_labels", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "simility_decision_id", null: false
    t.string "label", null: false
    t.index ["simility_decision_id"], name: "simility_decision_labels_simility_decision_id_fk"
  end

  create_table "simility_decision_lead_labels", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "simility_decision_id", null: false
    t.string "label", null: false
    t.float "value", limit: 24, null: false
    t.index ["simility_decision_id"], name: "simility_decision_lead_labels_simility_decision_id_fk"
  end

  create_table "simility_decision_reasons", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "simility_decision_id", null: false
    t.string "reason", null: false
    t.index ["simility_decision_id"], name: "simility_decision_reasons_simility_decision_id_fk"
  end

  create_table "simility_decisions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "simility_id", null: false
    t.string "entity", null: false
    t.integer "score"
    t.string "note", limit: 4096
    t.string "queue"
    t.datetime "simility_timestamp", null: false
    t.string "decision_by"
    t.string "queue_state"
    t.float "sc_ml_1", limit: 24
    t.float "sc_ml_2", limit: 24
    t.float "sc_ml_3", limit: 24
    t.float "sc_ml_4", limit: 24
    t.integer "segment_number"
    t.string "segment_name"
    t.enum "proposed_action", limit: ["suspend", "cancel", "un_suspend"]
    t.string "action_taken"
    t.integer "user_id"
    t.string "proposed_action_reason"
    t.index ["user_id"], name: "index_simility_decisions_on_user_id"
  end

  create_table "stores", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "name", default: "", null: false
    t.integer "merchant_id", null: false
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "address", default: "", null: false
    t.string "address2", default: "", null: false
    t.string "city", default: "", null: false
    t.string "state_code", limit: 2, default: "", null: false
    t.bigint "zip_code", null: false
    t.decimal "longitude", precision: 15, scale: 12, default: "0.0", null: false
    t.decimal "latitude", precision: 15, scale: 12, default: "0.0", null: false
    t.bigint "phone"
    t.string "google_place_reference"
    t.string "google_place_url"
    t.integer "price_level", default: 0, null: false
    t.float "rating", limit: 24, default: 0.0, null: false
    t.integer "review_count", default: 0, null: false
    t.index ["longitude", "latitude"], name: "index_stores_on_longitude_and_latitude"
    t.index ["merchant_id"], name: "index_stores_on_merchant_id"
  end

  create_table "sub_categories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "category", default: "", null: false
    t.string "name", default: "", null: false
    t.index ["category"], name: "index_sub_categories_on_category"
  end

  create_table "test_runs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "user_email", default: "", null: false
    t.string "platform", default: "", null: false
    t.integer "exp_id"
    t.string "url_params", default: "", null: false
    t.text "notes"
    t.boolean "test_prod", default: false
  end

  create_table "text_results", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "recipient_id", null: false
    t.bigint "recipient_phone", null: false
    t.string "message", default: "", null: false
    t.string "error", default: "", null: false
    t.index ["recipient_id"], name: "index_text_results_on_recipient_id"
  end

  create_table "texts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "recipient_id", null: false
    t.bigint "recipient_phone", null: false
    t.string "message", default: "", null: false
    t.index ["recipient_id"], name: "index_texts_on_recipient_id"
  end

  create_table "tids", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "tid", default: "", null: false
    t.integer "merchant_id", null: false
    t.integer "store_id", null: false
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["merchant_id"], name: "index_tids_on_merchant_id"
    t.index ["store_id"], name: "index_tids_on_store_id"
  end

  create_table "tracking_dislikes", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.integer "user_id", null: false
    t.integer "merchant_id", null: false
    t.index ["merchant_id"], name: "merchant_id_index"
    t.index ["user_id"], name: "user_id_index"
  end

  create_table "transaction_locations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "descriptor", default: "", null: false
    t.string "merchant_name", default: "", null: false
    t.decimal "latitude", precision: 10, scale: 6, null: false
    t.decimal "longitude", precision: 10, scale: 6, null: false
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "country"
    t.integer "zip_code"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "chain_type", limit: ["none", "inter_city", "intra_city", "both"], default: "none", null: false
    t.index ["descriptor"], name: "index_transaction_locations_on_descriptor"
  end

  create_table "transfer_rule_direct_deposits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_bank_account_id", null: false
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.enum "status", limit: ["active", "paused", "inactive"], default: "active", null: false
    t.enum "amount_type", limit: ["percent", "fixed"], null: false
    t.index ["user_bank_account_id"], name: "index_transfer_rule_direct_deposits_on_user_bank_account_id"
  end

  create_table "user_activities", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.string "name", null: false
    t.string "value", default: "", null: false
    t.index ["user_id"], name: "index_user_activities_on_user_id"
  end

  create_table "user_adjustments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", default: 0, null: false
    t.integer "user_deal_id"
    t.enum "type", limit: ["deal_purchase", "deal_cancel", "deal_redeem", "deal_unredeem", "promotional_value", "cash_reward", "overdraft_credit", "support", "savings_transfer", "savings_roundup", "savings_bonus", "write_off", "atm_fee_credit", "savings_monthly_bonus", "check_deposit", "check_deposit_treasury", "check_deposit_hold", "check_deposit_hold_treasury", "check_deposit_hold_manual", "check_deposit_hold_release", "check_deposit_hold_release_treasury", "check_deposit_hold_release_manual", "check_deposit_return", "check_deposit_return_treasury", "cash_load_fee_credit", "atm_surcharge_credit", "non_member_send_funds", "non_member_receive_funds", "overdraft_tip", "checking_security_deposit_transfer", "security_deposit_secured_card_transfer", "checking_secured_card_transfer"], default: "deal_redeem", null: false
    t.enum "purchase_method", limit: ["none", "credit_card", "account"], default: "none", null: false
    t.enum "transaction_status", limit: ["none", "pending", "settled", "expired"], default: "pending", null: false
    t.enum "status", limit: ["none", "failed", "succeeded", "reversed", "declined"], default: "failed", null: false
    t.string "processor_transaction_id", default: "", null: false
    t.string "adjustment_transaction_id", default: "", null: false
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.string "reversal_transaction_id", default: "", null: false
    t.integer "external_card_transfer_id"
    t.integer "related_user_adjustment_id"
    t.integer "payment_transaction_id", default: 0, null: false
    t.string "details", default: "", null: false
    t.integer "user_check_deposit_id"
    t.index ["external_card_transfer_id"], name: "index_user_adjustments_on_external_card_transfer_id"
    t.index ["related_user_adjustment_id"], name: "index_user_adjustments_on_related_user_adjustment_id"
    t.index ["status", "created_at"], name: "index_user_deal_transactions_on_status_and_created_at"
    t.index ["type", "created_at"], name: "index_user_adjustments_on_type_and_created_at"
    t.index ["user_check_deposit_id"], name: "user_adjustments_user_check_deposit_id_fk"
    t.index ["user_deal_id"], name: "index_user_deal_transactions_on_user_deal_id"
    t.index ["user_id"], name: "index_user_deal_transactions_on_user_id"
  end

  create_table "user_bank_account_balance_histories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.integer "user_id", null: false
    t.integer "user_bank_account_id", null: false
    t.date "statement_date", null: false
    t.enum "user_bank_account_type", limit: ["savings", "checking", "check_deposit_hold", "overdraft", "security_deposit", "secured_credit"], null: false
    t.decimal "ending_current_balance", precision: 12, scale: 2, null: false
    t.decimal "ending_available_balance", precision: 12, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_bank_account_id"], name: "by_user_bank_account_id"
    t.index ["user_bank_account_type"], name: "uba_balance_history_uba_type"
    t.index ["user_id"], name: "index_user_bank_account_balance_histories_on_user_id"
  end

  create_table "user_bank_accounts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.enum "type", limit: ["savings", "checking", "check_deposit_hold", "overdraft", "security_deposit", "secured_credit"], default: "checking", null: false
    t.bigint "account_number", null: false
    t.bigint "external_account_id", null: false
    t.integer "product_id", null: false
    t.enum "status", limit: ["active", "cancelled", "cancelled_no_refund", "submitted", "suspended", "failed_id"], default: "active", null: false
    t.datetime "written_off_at"
    t.boolean "virtual_account", default: false, null: false
    t.decimal "balance_limit", precision: 12, scale: 2, default: "-1.0", null: false
    t.decimal "credit_limit", precision: 12, scale: 2, default: "0.0", null: false
    t.index ["account_number"], name: "index_user_bank_accounts_on_account_number", unique: true
    t.index ["external_account_id"], name: "index_user_bank_accounts_on_external_account_id"
    t.index ["user_id"], name: "index_user_bank_accounts_on_user_id"
  end

  create_table "user_biller_payments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", default: 0, null: false
    t.integer "user_biller_id", default: 0, null: false
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "process_at", null: false
    t.string "memo"
    t.integer "external_id"
    t.enum "status", limit: ["submitted", "processed", "mailed", "cashed", "bounced", "failed", "expired"], default: "submitted", null: false
    t.index ["user_biller_id"], name: "index_user_biller_payments_on_user_biller_id"
    t.index ["user_id"], name: "index_bill_payments_on_user_id"
  end

  create_table "user_billers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", default: 0, null: false
    t.string "account_number", default: "CHIME", null: false
    t.string "name", default: "", null: false
    t.string "address1", default: "", null: false
    t.string "address2"
    t.string "city", default: "", null: false
    t.string "state_code", default: "", null: false
    t.string "zip_code", default: "", null: false
    t.string "phone", default: ""
    t.string "category", default: ""
    t.boolean "is_deleted", default: false, null: false
    t.integer "external_id", default: 0
    t.index ["user_id"], name: "index_billers_on_user_id"
  end

  create_table "user_bot_conversations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "number_of_exchanges"
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.boolean "ticket_created", default: false, null: false
    t.index ["user_id"], name: "user_bot_conversations_user_id_fk"
  end

  create_table "user_bot_exchange_entities", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_bot_exchange_id", null: false
    t.string "name", null: false
    t.string "value"
    t.float "confidence", limit: 24
    t.integer "start_location"
    t.integer "end_location"
    t.index ["user_bot_exchange_id"], name: "user_bot_exchange_entities_user_bot_exchange_id_fk"
  end

  create_table "user_bot_exchanges", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.string "question", limit: 4096, default: "", null: false
    t.string "response", limit: 4096
    t.string "intent"
    t.float "confidence", limit: 24
    t.integer "user_bot_conversation_id"
    t.boolean "bot_was_correct"
    t.boolean "bot_was_fixed"
    t.boolean "propagated_to_ci", default: false, null: false
    t.string "notes"
    t.boolean "customized_response", default: false, null: false
    t.float "response_time", limit: 24
    t.boolean "ticket_created", default: false, null: false
    t.integer "original_user_bot_exchange_id"
    t.integer "set"
    t.text "context"
    t.index ["original_user_bot_exchange_id"], name: "user_bot_exchanges_original_user_bot_exchange_id_fk"
    t.index ["user_bot_conversation_id"], name: "user_bot_exchanges_user_bot_conversation_id_fk"
    t.index ["user_id"], name: "user_bot_exchanges_user_id_fk"
  end

  create_table "user_calls", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.enum "type", limit: ["activation_reminder"], default: "activation_reminder", null: false
    t.integer "num_calls", default: 1, null: false
    t.index ["user_id"], name: "index_user_calls_on_user_id"
  end

  create_table "user_card_reissues", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.enum "delivery_type", limit: ["express", "standard"], default: "standard", null: false
    t.boolean "allowed_express_at_time_of_reissue", default: false, null: false
    t.integer "admin_user_id", default: 1, null: false
    t.enum "type", limit: ["lost", "stolen", "reissue"], default: "lost", null: false
    t.integer "card_id"
    t.index ["user_id"], name: "index_user_card_reissues_on_user_id"
  end

  create_table "user_check_deposit_holds", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "user_check_deposit_id", null: false
    t.enum "status", limit: ["failed", "applied", "reversed"], default: "failed"
    t.integer "user_adjustment_id"
    t.datetime "expires_at", null: false
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.boolean "manual", default: false, null: false
    t.integer "release_user_adjustment_id", default: 0, null: false
    t.index ["status", "expires_at"], name: "index_user_check_deposit_holds_on_status_and_expires_at"
    t.index ["user_adjustment_id"], name: "index_user_check_deposit_holds_on_user_adjustment_id"
    t.index ["user_check_deposit_id"], name: "index_user_check_deposit_holds_on_user_check_deposit_id"
    t.index ["user_id"], name: "index_user_check_deposit_holds_on_user_id"
  end

  create_table "user_check_deposits", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.bigint "transaction_id", null: false
    t.decimal "entered_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.enum "status", limit: ["failed", "processing", "invalid_images", "under_review", "accepted", "rejected", "posted", "returned"], default: "processing", null: false
    t.integer "deposit_user_adjustment_id"
    t.enum "type", limit: ["treasury", "standard"], default: "standard"
    t.integer "reversal_user_adjustment_id", default: 0, null: false
    t.string "return_reason", default: "", null: false
    t.decimal "approved_amount", precision: 12, scale: 2
    t.datetime "approved_at"
    t.string "approved_by"
    t.string "biz_rule_engine_message"
    t.string "check_account_number"
    t.bigint "check_number"
    t.string "check_routing_number"
    t.datetime "date_of_deposit"
    t.string "operator_message"
    t.string "front_file_name"
    t.string "front_content_type"
    t.integer "front_file_size"
    t.datetime "front_updated_at"
    t.string "rear_file_name"
    t.string "rear_content_type"
    t.integer "rear_file_size"
    t.datetime "rear_updated_at"
    t.string "image_error_code"
    t.string "operator_user_name"
    t.decimal "recognized_amount", precision: 12, scale: 2
    t.float "simility_score", limit: 24
    t.enum "simility_decision", limit: ["accept", "reject", "review"]
    t.string "simility_reason"
    t.string "simility_note"
    t.enum "cashier_verify_status", limit: ["pending", "rejected", "passed"]
    t.enum "money_order_verify_status", limit: ["pending", "rejected", "passed"], default: "pending"
    t.string "giact_response_code"
    t.string "bank_of_first_deposit_indicator"
    t.index ["status"], name: "index_user_check_deposits_on_status"
    t.index ["transaction_id"], name: "index_user_check_deposits_on_transaction_id"
    t.index ["user_id"], name: "index_user_check_deposits_on_user_id"
  end

  create_table "user_cohorts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.boolean "swiped"
    t.boolean "card_ever_activated"
    t.boolean "recurring_direct_deposit"
    t.boolean "ever_had_payroll_dd"
    t.boolean "zendesk_direct_depositor"
    t.index ["user_id"], name: "index_user_cohorts_on_user_id", unique: true
  end

  create_table "user_connected_billers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.enum "status", limit: ["syncing", "zero_balance", "overdue", "authenticate", "hold", "upcoming", "pending", "paid"], default: "authenticate", null: false
    t.string "company_name", default: "", null: false
    t.string "company_id", default: "", null: false
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.decimal "balance", precision: 12, scale: 2
    t.datetime "due_date"
    t.decimal "last_paid_amount", precision: 12, scale: 2
    t.datetime "last_paid_at"
    t.boolean "auto_pay", default: false, null: false
    t.string "headline_title", default: "", null: false
    t.string "headline_type", default: "", null: false
    t.string "company_logo_url", default: "", null: false
    t.boolean "company_logo_background", default: false, null: false
    t.string "company_svg_logo_url", default: "", null: false
    t.string "company_svg_logo_color", default: "", null: false
    t.datetime "status_updated_at"
    t.index ["user_id"], name: "index_user_connected_billers_on_user_id"
  end

  create_table "user_contact_requests", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.integer "user_contact_id", null: false
    t.string "memo"
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.enum "status", limit: ["failed", "sent", "paid"], default: "failed"
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["user_contact_id"], name: "user_contact_requests_user_contact_id_fk"
  end

  create_table "user_contact_transfers", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_contact_id", null: false
    t.string "memo"
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.integer "user_id", null: false
    t.enum "status", limit: ["failed", "succeeded", "reversed", "declined"], default: "failed", null: false
    t.integer "adjustment_transaction_id", default: 0, null: false
    t.datetime "recipient_messaged_at"
    t.integer "recipient_id", null: false
    t.integer "payment_transaction_id", default: 0, null: false
    t.integer "request_transaction_id", default: 0, null: false
    t.string "platform"
    t.string "device_string"
    t.string "client_ip"
    t.boolean "triggered_mfa", default: false, null: false
    t.index ["recipient_id"], name: "index_user_contact_transfers_on_recipient_id"
    t.index ["user_contact_id"], name: "index_user_contact_transfers_on_user_contact_id"
    t.index ["user_id"], name: "index_user_contact_transfers_on_user_id"
  end

  create_table "user_contacts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", default: 0
    t.integer "contact_user_id"
    t.string "identifier", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "is_deleted", default: false, null: false
    t.index ["contact_user_id"], name: "user_contacts_contact_user_id_fk"
    t.index ["identifier", "user_id"], name: "index_user_contacts_on_identifier_and_user_id", unique: true
    t.index ["user_id", "contact_user_id"], name: "index_user_contacts_on_user_id_and_contact_user_id", unique: true
    t.index ["user_id"], name: "index_user_contacts_on_user_id"
  end

  create_table "user_deals", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.integer "user_id", null: false
    t.integer "deal_id", null: false
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.enum "status", limit: ["purchased", "redeemed", "cancelled", "expired"], default: "purchased", null: false
    t.integer "merchant_id"
    t.boolean "cancelable", default: true, null: false
    t.decimal "balance", precision: 12, scale: 2, default: "0.0", null: false
    t.boolean "is_gift", default: false, null: false
    t.boolean "redeemable", default: true, null: false
    t.integer "gift_giver_id", default: 0, null: false
    t.integer "gift_recipient_id", default: 0, null: false
    t.string "gift_recipient_name", default: "", null: false
    t.string "gift_recipient_email", default: "", null: false
    t.bigint "gift_recipient_phone", default: 0, null: false
    t.string "gift_token", default: "", null: false
    t.enum "gift_status", limit: ["offered", "received", "accepted", "cancelled", "redeemed"], default: "offered", null: false
    t.boolean "is_reward", default: false, null: false
    t.string "gift_message", limit: 4096, default: "", null: false
    t.string "processing_transaction_id"
    t.decimal "processing_adjustment_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.index ["deal_id", "status"], name: "index_user_deals_on_deal_id_and_status"
    t.index ["gift_giver_id"], name: "index_user_deals_on_gift_giver_id"
    t.index ["gift_recipient_id"], name: "index_user_deals_on_gift_recipient_id"
    t.index ["merchant_id"], name: "index_user_deals_on_merchant_id"
    t.index ["user_id"], name: "user_deals_user_id_fk"
  end

  create_table "user_devices", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.integer "user_id", null: false
    t.string "token", default: "", null: false
    t.enum "model", limit: ["iOS", "android"], null: false
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "gcm_registration_id", default: "", null: false
    t.index ["token"], name: "index_user_devices_on_token", unique: true
    t.index ["user_id"], name: "index_user_devices_on_user_id"
  end

  create_table "user_dispute_claim_transactions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_dispute_claim_id", null: false
    t.bigint "transaction_id", default: 0, null: false
    t.boolean "pending_on_create", default: false
    t.string "lean_id"
    t.string "card_number"
    t.bigint "galileo_posted_transaction_id"
    t.string "auth_id"
    t.string "source_id"
    t.bigint "alert_authorization_event_id"
    t.index ["alert_authorization_event_id"], name: "alert_authorization_event_id"
    t.index ["galileo_posted_transaction_id"], name: "galileo_posted_transaction_id"
    t.index ["transaction_id"], name: "index_user_dispute_claim_transactions_on_transaction_id"
    t.index ["user_dispute_claim_id"], name: "index_user_dispute_tran_map_on_user_dispute_claim_id"
  end

  create_table "user_dispute_claim_updates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.integer "user_dispute_claim_id", default: 0, null: false
    t.integer "user_dispute_claim_transaction_id", default: 0, null: false
    t.datetime "provisional_credit_reversed"
    t.datetime "datetime"
    t.integer "key"
    t.string "customer_name"
    t.string "claim_status"
    t.datetime "status_updated"
    t.decimal "provisional_credit", precision: 12, scale: 2, default: "0.0"
    t.datetime "original_notice_date"
    t.string "first_load_timeframe"
    t.datetime "written_form_date"
    t.datetime "resolution_date"
    t.string "reason"
    t.string "resolution_code"
    t.string "investigator"
    t.datetime "provisional_credit_deadline"
    t.boolean "provisional_credit_issued"
    t.datetime "resolution_deadline"
    t.datetime "credit_letter_date"
    t.datetime "provisional_credit_date"
    t.boolean "regulation_e"
    t.datetime "transaction_date"
    t.decimal "transaction_amount", precision: 12, scale: 2, default: "0.0"
    t.decimal "disputed_amount", precision: 12, scale: 2, default: "0.0"
    t.string "merchant_name"
    t.string "transaction_channel"
    t.string "close_code"
    t.boolean "chargeback"
    t.boolean "transaction_date_valid"
    t.string "payment_channel"
    t.string "transaction_type"
    t.string "cardholder_verification"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "parent_case_key"
    t.string "mcc"
    t.string "chargeback_reason_code"
    t.datetime "chargeback_date"
    t.datetime "retrieval_request_date"
    t.decimal "write_off_amount", precision: 12, scale: 2, default: "0.0"
    t.datetime "write_off_date"
    t.decimal "representment_amount", precision: 12, scale: 2, default: "0.0"
    t.datetime "representment_date"
    t.datetime "prearbitration_date"
    t.string "fees_adjusted"
    t.datetime "provisional_credit_reversal_expire_date"
    t.string "galileo_transaction_id"
    t.string "dispute_type"
    t.datetime "externally_modified"
    t.decimal "write_off_amount_no_chargeback_rights", precision: 12, scale: 2, default: "0.0"
    t.decimal "claim_amount", precision: 12, scale: 2, default: "0.0"
    t.boolean "anomalous"
    t.datetime "date_final_resolution_letter_sent"
    t.string "reason_code"
    t.index ["key", "externally_modified"], name: "index_user_dispute_claim_updates_on_key_and_externally_modified", unique: true
    t.index ["user_dispute_claim_id"], name: "index_dispute_updates_on_claim_id"
    t.index ["user_dispute_claim_transaction_id"], name: "index_dispute_updates_on_dispute_transaction_id"
  end

  create_table "user_dispute_claims", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.enum "reason", limit: ["atm_cash_not_received", "incorrect_amount_charged", "transaction_was_cancelled", "merchandise_was_returned", "duplicate_charge", "paid_for_goods_services_by_other_means", "non_receipt_of_goods_or_services", "unauthorized_transaction", "unauthorized_transfer", "duplicate_transfer_amount", "incorrect_transfer_amount", "transfer_to_incorrect_recipient", "transfer_not_received_by_recipient"], default: "atm_cash_not_received", null: false
    t.decimal "atm_amount_requested", precision: 12, scale: 2
    t.decimal "atm_amount_received", precision: 12, scale: 2
    t.decimal "amount_supposed_to_have_been_charged", precision: 12, scale: 2
    t.boolean "receipt_copy_available"
    t.datetime "date_transaction_cancelled"
    t.boolean "received_cancellation_confirmation_number"
    t.string "cancellation_confirmation_number"
    t.datetime "merchandise_return_date"
    t.boolean "merchandise_return_tracking_number_available"
    t.string "merchandise_return_tracking_number"
    t.boolean "merchant_seller_has_been_contacted"
    t.string "merchant_seller_response"
    t.datetime "duplicate_charge_date"
    t.datetime "original_charge_date"
    t.string "other_means_form_of_payment"
    t.boolean "has_receipt_with_other_means_payment_showing"
    t.datetime "non_receipt_expected_merchandise_receipt_date"
    t.boolean "non_receipt_merchant_contacted"
    t.string "non_receipt_merchant_response"
    t.datetime "last_authorized_tran_date_before_unauthorized_tran"
    t.string "last_authorized_tran_merchant_name_before_unauthorized_tran"
    t.boolean "card_holder_possesses_card_after_unauthorized_transaction"
    t.string "unauthorized_transaction_card_holder_pin_location"
    t.boolean "someone_else_had_access_to_unauthorized_transaction_card"
    t.string "name_of_person_who_had_access_to_unauthorized_transaction_card"
    t.boolean "were_additional_cards_lost_stolen_for_unauthorized_transaction"
    t.boolean "was_wallet_purse_stolen_for_unauthorized_transaction"
    t.text "additional_info"
    t.datetime "non_receipt_merchant_contacted_date"
    t.integer "admin_user_id", null: false
    t.boolean "email_sent", default: false
    t.boolean "was_phone_lost_stolen"
    t.string "expected_merchandise_service_purchased_received"
    t.boolean "correct"
    t.enum "dispute_type", limit: ["general", "pay_friends", "ach_debit"], default: "general", null: false
    t.boolean "recipient_of_transfer_known"
    t.string "recipient_of_transfer_name"
    t.boolean "unauthorized_transfer_phone_lost_stolen"
    t.boolean "allowed_someone_else_to_use_phone"
    t.boolean "locks_phone_with_pass_or_fingerprint"
    t.boolean "has_shared_passcode_with_someone_else"
    t.string "name_of_person_who_knows_passcode"
    t.boolean "has_shared_password_with_someone_else"
    t.string "name_of_person_who_knows_password"
    t.boolean "were_there_additional_unrecognized_charges"
    t.string "additional_unrecognized_charges"
    t.boolean "other_items_lost_stolen"
    t.boolean "has_filed_police_report"
    t.string "case_number_or_contact_info_for_police_report"
    t.decimal "amount_attempting_to_send", precision: 12, scale: 2, default: "0.0", null: false
    t.string "name_of_person_transfer_intended_for"
    t.string "email_or_phone_transfer_was_sent_to"
    t.boolean "has_contacted_recipient_to_resolve"
    t.string "recipient_contact_response"
    t.string "method_of_merchandise_return"
    t.bigint "duplicate_charge_original_transaction_id"
    t.string "lean_id"
    t.index ["user_id"], name: "index_user_dispute_transactions_on_user_id"
  end

  create_table "user_employers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer "user_id", null: false
    t.string "employer_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_employers_on_user_id"
  end

  create_table "user_fraud_controls", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.string "name", null: false
    t.boolean "value", default: false, null: false
    t.index ["user_id", "name"], name: "index_user_fraud_controls_on_user_id_and_name", unique: true
  end

  create_table "user_invites", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", default: 0, null: false
    t.enum "status", limit: ["invited", "joined", "enrolled", "funded"], default: "invited", null: false
    t.string "email", default: "", null: false
    t.integer "refer_a_friend_campaign_id", default: 0
    t.index ["refer_a_friend_campaign_id"], name: "index_user_invites_on_refer_a_friend_campaign_id"
    t.index ["user_id"], name: "index_user_invites_on_user_id"
  end

  create_table "user_limits", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", default: 0, null: false
    t.integer "daily_limit", default: 0, null: false
    t.integer "monthly_limit", default: 0, null: false
    t.enum "type", limit: ["ach", "debit", "bill_pay", "total_linked_cards", "current_linked_cards", "link_attempts", "declined_transfers", "debit_transfer_enabled", "friend_transfers", "check_deposits", "check_amount", "linked_accounts", "total_linked_accounts", "friend_transfer_amount", "check_deposit_enabled", "ach_push", "chatbot_enabled"], default: "ach", null: false
    t.integer "total_limit", default: 0, null: false
    t.integer "item_limit", default: 0, null: false
    t.index ["user_id"], name: "index_ach_limits_on_user_id"
  end

  create_table "user_merchant_blocks", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "merchant_id"
    t.string "descriptor", default: "", null: false
    t.string "merchant_number", default: "", null: false
    t.string "response_code", default: "05", null: false
    t.index ["merchant_id"], name: "user_merchant_blocks_merchant_id_fk"
    t.index ["user_id"], name: "user_merchant_blocks_user_id_fk"
  end

  create_table "user_merchants", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "merchant_id", null: false
    t.decimal "total_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.integer "total_visits", default: 0, null: false
    t.decimal "current_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.integer "current_visits", default: 0, null: false
    t.boolean "favorite"
    t.boolean "profiled", default: false, null: false
    t.boolean "remind_me", default: false, null: false
    t.index ["merchant_id"], name: "index_user_merchants_on_merchant_id"
    t.index ["user_id", "merchant_id"], name: "index_user_merchants_on_user_id_and_merchant_id", unique: true
    t.index ["user_id"], name: "index_user_merchants_on_user_id"
  end

  create_table "user_notifications", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", default: 0, null: false
    t.integer "notification_id", default: 0, null: false
    t.integer "type", default: 0, null: false
    t.integer "obj_id", default: 0, null: false
    t.integer "channels", default: 0, null: false
    t.datetime "delivered_at", null: false
    t.string "merchant_name", default: "", null: false
    t.string "deal_name", default: "", null: false
    t.decimal "transaction_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "cash_balance", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "deal_balance", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "promotional_value", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "purchase_value", precision: 12, scale: 2, default: "0.0", null: false
    t.string "user_name", default: "", null: false
    t.string "message", limit: 4096, default: "", null: false
    t.string "transaction_id", default: "", null: false
    t.boolean "dismissed", default: false
    t.string "request_id", default: "", null: false
    t.date "due_date"
    t.string "transaction_emoji"
    t.integer "mcc", default: 0, null: false
    t.string "conversation_id"
    t.decimal "suggested_tip", precision: 12, scale: 2, default: "0.0", null: false
    t.index ["notification_id"], name: "index_user_notifications_on_notification_id"
    t.index ["user_id"], name: "index_user_notifications_on_user_id"
  end

  create_table "user_perks", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "source_type", null: false
    t.integer "source_id", null: false
    t.integer "user_id", null: false
    t.decimal "roundup_bonus", precision: 3, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_type", "source_id"], name: "index_user_perks_on_source_type_and_source_id"
    t.index ["user_id", "source_type", "source_id"], name: "index_user_perks_on_user_id_and_source_type_and_source_id", unique: true
  end

  create_table "user_plaid_tokens", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.string "public_token", null: false
    t.string "access_token", default: ""
    t.boolean "mfa_reset_required", default: false, null: false
    t.integer "last_error_code", default: 0, null: false
    t.boolean "historical_pull_complete", default: false, null: false
    t.string "created_via", default: "", null: false
    t.string "item_id"
    t.string "v1_token"
    t.index ["access_token"], name: "index_user_plaid_tokens_on_access_token"
    t.index ["public_token"], name: "index_user_plaid_tokens_on_public_token"
    t.index ["user_id"], name: "index_user_plaid_tokens_on_user_id"
  end

  create_table "user_posted_transaction_locations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "transaction_id", null: false
    t.integer "transaction_location_id", null: false
    t.index ["transaction_location_id"], name: "index_user_posted_txn_locations_on_txn_location_id"
    t.index ["user_id", "transaction_id"], name: "index_user_posted_txn_locations_on_user_id_and_txn_id"
  end

  create_table "user_queued_transactions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "user_bank_account_id", null: false
    t.enum "status", limit: ["queued", "processing", "submitted", "processed", "failed", "cancelled"], default: "queued", null: false
    t.enum "type", limit: ["adjustment", "payment", "reversal", "fee"], default: "adjustment", null: false
    t.string "sub_type", default: "", null: false
    t.string "description", default: "", null: false
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.string "failure_code", default: "", null: false
    t.integer "user_adjustment_id"
    t.index ["status"], name: "index_user_queued_transactions_on_status"
    t.index ["user_adjustment_id"], name: "user_queued_transactions_user_adjustment_id_fk"
    t.index ["user_bank_account_id"], name: "index_user_queued_transactions_on_user_bank_account_id"
    t.index ["user_id"], name: "index_user_queued_transactions_on_user_id"
  end

  create_table "user_rewards", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", default: 0, null: false
    t.enum "type", limit: ["funding", "direct_deposit", "swipe"], default: "funding", null: false
    t.enum "status", limit: ["offered", "redeemed", "cancelled"], default: "offered", null: false
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "threshold", precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "expires_at", null: false
    t.index ["user_id"], name: "index_user_rewards_on_user_id"
  end

  create_table "user_roundup_bonus_eligibilities", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.boolean "eligible", null: false
    t.index ["eligible"], name: "index_user_roundup_bonus_eligibilities_on_eligible"
    t.index ["user_id"], name: "index_user_roundup_bonus_eligibilities_on_user_id", unique: true
  end

  create_table "user_settings", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.string "name", default: "", null: false
    t.string "value", default: "", null: false
    t.index ["user_id", "name"], name: "index_user_settings_on_user_id_and_name", unique: true
  end

  create_table "user_store_review_prompts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.boolean "ios", null: false
    t.datetime "prompted_at"
    t.index ["user_id"], name: "user_store_review_prompts_user_id_fk"
  end

  create_table "user_tokens", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", default: 0, null: false
    t.enum "type", limit: ["auth", "multi_factor_auth", "one_time_auth", "verify_email", "verify_phone", "reset_password", "unlock_account", "facebook", "referral", "ingo", "unbill", "cachet", "gclid", "ivr_l1_identified", "ivr_l2_authenticated"], default: "auth", null: false
    t.string "token", default: "", null: false
    t.string "device", default: "", null: false
    t.datetime "expires_at"
    t.index ["token"], name: "index_user_tokens_on_token"
    t.index ["user_id"], name: "index_user_tokens_on_user_id"
  end

  create_table "user_tracking_ids", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "track_id", null: false
    t.integer "user_id", null: false
    t.enum "provider", limit: ["segment", "tapfiliate", "appsflyer"], default: "segment", null: false
    t.index ["user_id"], name: "index_user_tracking_ids_on_user_id"
  end

  create_table "user_transaction_details", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "transaction_id", null: false
    t.decimal "latitude", precision: 10, scale: 6, default: "0.0", null: false
    t.decimal "longitude", precision: 10, scale: 6, default: "0.0", null: false
    t.text "notes", null: false
    t.string "label", default: "", null: false
    t.index ["user_id", "transaction_id"], name: "index_user_transaction_details_on_user_id_and_transaction_id", unique: true
  end

  create_table "user_transaction_locations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "transaction_id", null: false
    t.decimal "latitude", precision: 10, scale: 6, null: false
    t.decimal "longitude", precision: 10, scale: 6, null: false
    t.index ["user_id", "transaction_id"], name: "index_user_transaction_locations_on_user_id_and_transaction_id", unique: true
    t.index ["user_id"], name: "index_user_transaction_locations_on_user_id"
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "address", default: "", null: false
    t.string "city", default: "", null: false
    t.string "state_code", limit: 2, default: "", null: false
    t.bigint "zip_code", null: false
    t.bigint "phone", default: 0
    t.bigint "social_security_number", default: 0
    t.date "date_of_birth"
    t.string "encrypted_password", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.boolean "phone_verified", default: false, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "authentication_token"
    t.bigint "prn"
    t.string "address2", default: "", null: false
    t.enum "status", limit: ["active", "needs_enrollment", "cancelled", "cancelled_no_refund", "submitted", "suspended", "failed_id"], default: "needs_enrollment", null: false
    t.enum "gender", limit: ["male", "female"]
    t.decimal "last_latitude", precision: 10, scale: 6
    t.decimal "last_longitude", precision: 10, scale: 6
    t.string "ad_campaign_id"
    t.string "login_token"
    t.string "referral_token"
    t.enum "onboarding_variant", limit: ["original", "single", "streamline", "multi3", "stream_three", "v3_flow", "streamline_v2"], default: "streamline", null: false
    t.integer "next_onboarding_page", default: 2, null: false
    t.integer "referred_by", default: 0, null: false
    t.boolean "id_override", default: false, null: false
    t.string "affiliate_name"
    t.string "affiliate_user_id"
    t.boolean "unsubscribed", default: false, null: false
    t.integer "last_four_ssn", default: 0
    t.boolean "funded", default: false, null: false
    t.string "ssn_digest", default: ""
    t.integer "referral_deal_id"
    t.boolean "referral_bonus_eligible", default: false, null: false
    t.string "android_app_version"
    t.string "ios_app_version"
    t.string "occupation"
    t.datetime "sent_dd_form_at"
    t.string "source_of_income"
    t.string "nickname"
    t.string "referral_source", default: "", null: false
    t.boolean "store_review_prompt_candidate", default: false, null: false
    t.datetime "prompted_for_store_review_at"
    t.string "ios_version"
    t.string "android_version"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "preferred_name"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.integer "api_version"
    t.boolean "refer_a_friend_prompt_candidate", default: false, null: false
    t.datetime "prompted_for_refer_a_friend_at"
    t.boolean "direct_deposit_pest", default: false, null: false
    t.enum "suspended_for", limit: ["cash_withdrawal_after_transfer", "ach_rejection", "chargeback", "address_velocity", "ip_address_velocity", "ach_velocity", "debit_load_velocity", "debit_decline_code", "large_atm_withdrawals", "cash_on_cash_off", "debit_link_velocity", "cash_load_amount", "cash_load_velocity", "load_velocity", "spend_velocity", "large_balance", "merchant_credit", "foreign_transactions", "debit_decline_velocity", "check_to_own_address", "check_after_transfer", "large_check_mailed", "neg_balance_posted_txn", "reported_id_theft", "reported_load_fraud", "suspicious_account_access", "tainted_address", "tainted_phone_number", "tainted_email", "scheduled_for_closure", "returned_check", "duplicate_account", "load_fraud", "bad_documentation_received", "check_fraud", "device_id_velocity", "suspicious_email_domain", "transaction_decline_velocity", "suspicious_bank_account_link_attempts", "age_is_suspicious", "high_socure_score", "pay_friends_transfer_fraud", "bancorp_suspension_third_party_deposit", "bancorp_suspension_agreement_violation", "bancorp_load_fraud", "bancorp_suspicious_transfers", "bancorp_merchant_credit", "chime_third_party_deposit", "chime_suspension_agreement_violation", "third_party_legal_or_law_enforcement", "third_party_bankruptcy"]
    t.integer "stated_income"
    t.decimal "socure_enrollment_score", precision: 12, scale: 4
    t.integer "refer_a_friend_campaign_id"
    t.integer "weekly_roundup_bonus_multiple_reward_weeks_left", default: 0, null: false
    t.integer "weekly_roundup_bonus_multiple_raf_campaign_id"
    t.boolean "displayed_generic_in_app_message", default: false, null: false
    t.enum "cancelled_by", limit: ["chime_for_ach_rejection", "chime_for_altered_documents", "chime_for_cash_on_cash_off", "chime_for_credits_without_offsetting_debits", "chime_for_deceased_member", "chime_for_dispute_velocity", "chime_for_duplicate_account", "chime_for_id_theft", "chime_for_mobile_check_deposit_fraud", "chime_for_multiple_no_error_disputes", "chime_for_negative_balance_write-off", "chime_for_suspected_pay_friends_transfer_fraud", "chime_for_suspected_load_fraud", "chime_for_violation_of_terms_agreement", "bancorp_for_credits_without_offsetting_debits", "bancorp_for_restricted_cards_database", "bancorp_for_suspected_load_fraud", "bancorp_for_violation_of_terms_agreement", "chime", "bancorp", "member", "chime_for_debit_card_chargebacks", "third_party_legal_or_law_enforcement", "third_party_bankruptcy"]
    t.boolean "ofac_flagged", default: false
    t.integer "zip_last4", limit: 2
    t.string "referred_by_type"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["first_name", "last_name", "zip_code"], name: "index_users_on_first_and_last_name_and_zip"
    t.index ["funded"], name: "index_users_on_funded"
    t.index ["login_token"], name: "index_users_on_login_token"
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["phone"], name: "index_users_on_phone"
    t.index ["prn"], name: "index_users_on_prn"
    t.index ["refer_a_friend_campaign_id"], name: "index_users_on_refer_a_friend_campaign_id"
    t.index ["referral_deal_id"], name: "index_users_on_referral_deal_id"
    t.index ["referral_token"], name: "index_users_on_referral_token", unique: true
    t.index ["referred_by"], name: "index_users_on_referred_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["social_security_number"], name: "index_users_on_social_security_number"
    t.index ["ssn_digest"], name: "index_users_on_ssn_digest"
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["weekly_roundup_bonus_multiple_raf_campaign_id"], name: "index_users_on_weekly_roundup_bonus_multiple_raf_campaign_id"
  end

  create_table "vantiv_bins", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "bin", null: false
    t.string "brand", default: "", null: false
    t.string "bank", default: "", null: false
    t.string "type", default: "", null: false
    t.string "level", default: "", null: false
    t.string "isocountry", default: "", null: false
    t.string "info", default: "", null: false
    t.string "country_iso", default: "", null: false
    t.string "country2_iso", default: "", null: false
    t.string "country3_iso", default: "", null: false
    t.string "www", default: "", null: false
    t.string "phone", default: "", null: false
    t.string "fbank", default: "", null: false
    t.string "address", default: "", null: false
    t.boolean "exempt", default: true, null: false
    t.integer "fee", default: 0, null: false
    t.index ["bin"], name: "index_vantiv_bins_on_bin", unique: true
  end

  create_table "vantiv_chargeback_win_losses", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.string "org_id", default: "", null: false
    t.string "case_id", default: "", null: false
    t.string "payment_id", default: "", null: false
    t.integer "merchant_order_number", default: 0, null: false
    t.integer "account_suffix", default: 0, null: false
    t.integer "bin", default: 0, null: false
    t.string "payment_type", default: "", null: false
    t.string "reason_code", default: "", null: false
    t.string "reason_description", default: "", null: false
    t.date "date_issued", null: false
    t.date "date_received", null: false
    t.date "reply_by_date", null: false
    t.decimal "chargeback_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.date "auth_date", null: false
    t.decimal "auth_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.date "transaction_date", null: false
    t.string "purchase_currency", default: "", null: false
    t.decimal "purchase_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "secondary_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.string "settlement_currency", default: "", null: false
    t.decimal "settlement_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "secondary_settlement_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.date "activity_date", null: false
    t.date "settlement_date", null: false
    t.string "campaign", default: "", null: false
    t.string "merchant_name", default: "", null: false
    t.string "affiliate", default: "", null: false
    t.string "merchant_grouping_id", default: "", null: false
    t.string "reporting_group", default: "", null: false
    t.string "transaction_type", default: "", null: false
    t.string "transaction_reason", default: "", null: false
    t.string "batch_id", default: "", null: false
    t.string "session_id", default: "", null: false
    t.string "arn", default: "", null: false
    t.string "issuing_bank_name", default: "", null: false
    t.string "customer_id", default: "", null: false
    t.integer "merchant_transaction_id", default: 0, null: false
    t.string "billing_descriptor", default: "", null: false
    t.string "issuing_bank_country_code", default: "", null: false
    t.string "current_cycle", default: "", null: false
    t.string "won_lost", default: "", null: false
    t.index ["bin"], name: "index_vantiv_chargeback_win_losses_on_bin"
    t.index ["customer_id"], name: "index_vantiv_chargeback_win_losses_on_customer_id"
    t.index ["merchant_transaction_id"], name: "index_vantiv_chargeback_win_losses_on_merchant_transaction_id"
    t.index ["user_id"], name: "index_vantiv_chargeback_win_losses_on_user_id"
  end

  create_table "vantiv_chargebacks", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.string "case_id", default: "", null: false
    t.string "litle_payment_id", default: "", null: false
    t.integer "merchant_order_number", default: 0, null: false
    t.integer "account_suffix", default: 0, null: false
    t.integer "bin", default: 0, null: false
    t.string "payment_type", default: "", null: false
    t.string "reason_code", default: "", null: false
    t.string "reason_description", default: "", null: false
    t.date "date_issued", null: false
    t.date "date_received", null: false
    t.date "reply_by_date", null: false
    t.string "chargeback_currency", default: "", null: false
    t.decimal "chargeback_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.date "auth_date", null: false
    t.string "auth_currency", default: "", null: false
    t.decimal "auth_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.string "transaction_purchase_currency", default: "", null: false
    t.decimal "transaction_purchase_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.string "transaction_settlement_currency", default: "", null: false
    t.decimal "transaction_settlement_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.date "activity_date", null: false
    t.date "settlement_date", null: false
    t.string "activity", default: "", null: false
    t.string "cycle", default: "", null: false
    t.string "campaign", default: "", null: false
    t.string "merchant_name", default: "", null: false
    t.string "affiliate", default: "", null: false
    t.string "merchant_grouping_id", default: "", null: false
    t.string "reporting_group", default: "", null: false
    t.string "transaction_type", default: "", null: false
    t.string "batch_id", default: "", null: false
    t.string "session_id", default: "", null: false
    t.string "arn", default: "", null: false
    t.string "customer_id", default: "", null: false
    t.integer "merchant_transaction_id", default: 0, null: false
    t.string "billing_descriptor", default: "", null: false
    t.string "assigned_to", default: "", null: false
    t.string "assigned_to_user_type", default: "", null: false
    t.integer "merchant_id", default: 0, null: false
    t.string "issuing_bank", default: "", null: false
    t.string "presenter", default: "", null: false
    t.string "transaction_secondary_amount", default: "", null: false
    t.string "transaction_secondary_settlement_amount", default: "", null: false
    t.date "transaction_date", null: false
    t.string "issuing_bank_country_code", default: "", null: false
    t.index ["bin"], name: "index_vantiv_chargebacks_on_bin"
    t.index ["customer_id"], name: "index_vantiv_chargebacks_on_customer_id"
    t.index ["merchant_transaction_id"], name: "index_vantiv_chargebacks_on_merchant_transaction_id"
    t.index ["user_id"], name: "index_vantiv_chargebacks_on_user_id"
  end

  create_table "vantiv_settled_sales", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "user_id", null: false
    t.string "reporting_group", default: "", null: false
    t.string "merchant", default: "", null: false
    t.date "activity_date", null: false
    t.string "litle_payment_id", default: "", null: false
    t.string "parent_litle_payment_id", default: "", null: false
    t.integer "merchant_order_number", default: 0, null: false
    t.string "txn_type", default: "", null: false
    t.string "purchase_currency", default: "", null: false
    t.decimal "purchase_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.string "settlement_currency", default: "", null: false
    t.decimal "settlement_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.string "payment_type", default: "", null: false
    t.integer "account_suffix", default: 0, null: false
    t.integer "bin", default: 0, null: false
    t.string "response_reason_message", default: "", null: false
    t.string "batch_id", default: "", null: false
    t.string "session_id", default: "", null: false
    t.string "arn", default: "", null: false
    t.string "interchange_rate", default: "", null: false
    t.string "customer_id", default: "", null: false
    t.integer "merchant_transaction_id", default: 0, null: false
    t.string "affiliate", default: "", null: false
    t.string "campaign", default: "", null: false
    t.string "merchant_grouping_id", default: "", null: false
    t.string "token_number", default: "", null: false
    t.datetime "transaction_processing_timestamp", null: false
    t.decimal "approximate_interchange_fee_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "interchange_flat_rate", precision: 12, scale: 8, default: "0.0", null: false
    t.decimal "interchange_percent_rate", precision: 12, scale: 8, default: "0.0", null: false
    t.string "funding_method", default: "", null: false
    t.string "issuing_bank", default: "", null: false
    t.string "billing_descriptor", default: "", null: false
    t.integer "merchant_id", default: 0, null: false
    t.string "presenter", default: "", null: false
    t.string "litle_xml_reporting_group", default: "", null: false
    t.string "customer_reference", default: "", null: false
    t.date "settlement_date", null: false
    t.index ["bin"], name: "index_vantiv_settled_sales_on_bin"
    t.index ["customer_id"], name: "index_vantiv_settled_sales_on_customer_id"
    t.index ["litle_payment_id"], name: "index_vantiv_settled_sales_on_litle_payment_id"
    t.index ["merchant_order_number"], name: "index_vantiv_settled_sales_on_merchant_order_number"
    t.index ["parent_litle_payment_id"], name: "index_vantiv_settled_sales_on_parent_litle_payment_id"
    t.index ["user_id"], name: "index_vantiv_settled_sales_on_user_id"
  end

  create_table "versions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "zendesk_priority_cohorts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.enum "priority", limit: ["low", "normal", "high", "urgent"], default: "low", null: false
    t.integer "cohort_id_1"
    t.integer "cohort_id_2"
    t.integer "cohort_id_3"
    t.integer "cohort_id_4"
    t.integer "cohort_id_5"
    t.integer "user_count", default: 0, null: false
    t.index ["cohort_id_1"], name: "index_zendesk_priority_cohorts_on_cohort_id_1"
    t.index ["cohort_id_2"], name: "index_zendesk_priority_cohorts_on_cohort_id_2"
    t.index ["cohort_id_3"], name: "index_zendesk_priority_cohorts_on_cohort_id_3"
    t.index ["cohort_id_4"], name: "index_zendesk_priority_cohorts_on_cohort_id_4"
    t.index ["cohort_id_5"], name: "index_zendesk_priority_cohorts_on_cohort_id_5"
    t.index ["priority"], name: "index_zendesk_priority_cohorts_on_priority", unique: true
  end

  create_table "zendesk_ticket_subjects", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
    t.string "subject"
    t.integer "sort_order", null: false
    t.string "response_time"
    t.index ["subject"], name: "index_zendesk_ticket_subjects_on_subject", unique: true
  end

  create_table "zips", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.integer "zip", null: false
    t.string "city"
    t.string "state"
    t.string "county"
    t.decimal "latitude", precision: 6, scale: 3, null: false
    t.decimal "longitude", precision: 6, scale: 3, null: false
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["zip"], name: "index_zips_on_zip"
  end

  add_foreign_key "account_events", "users", name: "account_events_user_id_fk"
  add_foreign_key "account_savings_goal_targets", "account_savings_goals", name: "account_savings_goal_id_fk"
  add_foreign_key "account_savings_goals", "user_bank_accounts", name: "user_bank_account_id_fk"
  add_foreign_key "ach_accounts", "users", name: "ach_accounts_user_id_fk"
  add_foreign_key "ach_transfers", "ach_accounts", name: "ach_transfers_ach_account_id_fk"
  add_foreign_key "alert_transaction_events", "users", name: "alert_transaction_events_user_id_fk"
  add_foreign_key "auto_transfer_rules", "ach_accounts", name: "ach_transfer_rules_ach_account_id_fk"
  add_foreign_key "auto_transfer_rules", "external_cards", name: "auto_transfer_rules_external_card_id_fk"
  add_foreign_key "auto_transfer_rules", "users", name: "ach_transfer_rules_user_id_fk"
  add_foreign_key "bot_ci_run_intent_tests", "bot_ci_runs", column: "bot_ci_runs_id"
  add_foreign_key "bot_ci_run_user_exchanges", "bot_ci_questions", name: "bot_ci_run_question_intentions_bot_ci_question_id_fk"
  add_foreign_key "bot_ci_run_user_exchanges", "bot_ci_runs", name: "bot_ci_run_question_intentions_bot_ci_run_id_fk"
  add_foreign_key "bulletin_series", "bulletin_categories", name: "bulletin_series_bulletin_category_id_fk"
  add_foreign_key "bulletin_series", "cohorts", name: "bulletin_series_cohort_id_fk"
  add_foreign_key "bulletins", "bulletin_series", name: "bulletins_bulletin_series_id_fk"
  add_foreign_key "bulletins", "cohorts", name: "bulletins_cohort_id_fk"
  add_foreign_key "categories", "merchant_categories", name: "categories_merchant_category_id_fk"
  add_foreign_key "cohort_users", "cohorts", name: "cohort_users_cohort_id_fk"
  add_foreign_key "cohorts", "cohorts", column: "segment_parent_id", name: "cohorts_segment_parent_id_fk"
  add_foreign_key "cohorts", "deals", column: "custom_deal_id", name: "cohorts_custom_deal_id_fk"
  add_foreign_key "cohorts", "deals", column: "redeemed_deal_id", name: "cohorts_redeemed_deal_id_fk"
  add_foreign_key "conversation_messages", "conversations", name: "conversation_messages_conversation_id_fk"
  add_foreign_key "conversations", "users", name: "conversations_user_id_fk"
  add_foreign_key "custom_deal_users", "deals", name: "custom_deal_users_deal_id_fk"
  add_foreign_key "custom_deal_users", "users", name: "custom_deal_users_user_id_fk"
  add_foreign_key "deal_categories", "categories", name: "deal_categories_category_id_fk"
  add_foreign_key "deal_categories", "deals", name: "deal_categories_deal_id_fk"
  add_foreign_key "deal_requests", "merchant_deal_requests", name: "deal_requests_merchant_deal_request_id_fk"
  add_foreign_key "deal_requests", "merchants", name: "deal_requests_merchant_id_fk"
  add_foreign_key "deal_requests", "users", name: "deal_requests_user_id_fk"
  add_foreign_key "deals", "cohorts", name: "deals_cohort_id_fk"
  add_foreign_key "deals", "merchant_categories", name: "deals_merchant_category_id_fk"
  add_foreign_key "deals", "merchants", name: "deals_merchant_id_fk"
  add_foreign_key "delayed_jobs", "users", name: "delayed_jobs_user_id_fk"
  add_foreign_key "external_api_request_deals", "deals", name: "external_api_request_deals_deal_id_fk"
  add_foreign_key "external_api_request_deals", "external_api_requests", name: "external_api_request_deals_external_api_request_id_fk"
  add_foreign_key "external_api_requests", "deals", name: "galileo_api_requests_deal_id_fk"
  add_foreign_key "external_api_requests", "user_adjustments", name: "transaction_requests_user_adjustment_id_fk"
  add_foreign_key "external_card_transfers", "external_cards", name: "external_card_transfers_external_card_id_fk"
  add_foreign_key "external_card_transfers", "users", name: "external_card_transfers_user_id_fk"
  add_foreign_key "external_cards", "users", name: "external_cards_user_id_fk"
  add_foreign_key "external_merchant_blocks", "external_merchants", name: "external_merchant_blocks_external_merchant_id_fk"
  add_foreign_key "galileo_account_cards", "user_bank_accounts", name: "galileo_account_cards_user_bank_account_id_fk"
  add_foreign_key "galileo_authorized_transactions", "users", name: "galileo_authorized_transactions_user_id_fk"
  add_foreign_key "generic_in_app_messages", "cohorts", name: "generic_in_app_messages_cohort_id_fk"
  add_foreign_key "landing_pages", "experiments", name: "landing_pages_experiment_id_fk"
  add_foreign_key "merchant_categories", "merchant_parent_categories", name: "merchant_categories_merchant_parent_category_id_fk"
  add_foreign_key "merchant_deal_requests", "merchants", name: "merchant_deal_requests_merchant_id_fk"
  add_foreign_key "merchant_notifications", "merchants", name: "merchant_notifications_merchant_id_fk"
  add_foreign_key "merchant_notifications", "notifications", name: "merchant_notifications_notification_id_fk"
  add_foreign_key "merchant_users", "merchants", name: "merchant_users_merchant_id_fk"
  add_foreign_key "merchants", "merchant_categories", name: "merchants_merchant_category_id_fk"
  add_foreign_key "notification_templates", "notifications", name: "notification_templates_notification_id_fk"
  add_foreign_key "partner_user_requests", "partner_users", name: "partner_user_requests_partner_user_id_fk"
  add_foreign_key "partner_user_webhooks", "partner_users", name: "partner_user_webhooks_partner_user_id_fk"
  add_foreign_key "partner_user_webhooks", "users", name: "partner_user_webhooks_user_id_fk"
  add_foreign_key "pay_friends", "user_adjustments", column: "receiver_adjustment_id"
  add_foreign_key "pay_friends", "user_adjustments", column: "sender_adjustment_id"
  add_foreign_key "pay_friends", "user_contact_transfers"
  add_foreign_key "pay_friends", "users", column: "receiver_id"
  add_foreign_key "pay_friends", "users", column: "sender_id"
  add_foreign_key "personal_deal_configs", "cohorts", name: "personal_deal_configs_cohort_id_fk"
  add_foreign_key "refer_a_friend_campaigns", "cohorts", name: "refer_a_friend_campaigns_cohort_id_fk"
  add_foreign_key "simility_decision_labels", "simility_decisions", name: "simility_decision_labels_simility_decision_id_fk"
  add_foreign_key "simility_decision_lead_labels", "simility_decisions", name: "simility_decision_lead_labels_simility_decision_id_fk"
  add_foreign_key "simility_decision_reasons", "simility_decisions", name: "simility_decision_reasons_simility_decision_id_fk"
  add_foreign_key "simility_decisions", "users", name: "simility_decisions_user_id_fk"
  add_foreign_key "stores", "merchants", name: "stores_merchant_id_fk"
  add_foreign_key "transfer_rule_direct_deposits", "user_bank_accounts", name: "transfer_rule_direct_deposit_user_bank_account_id_fk"
  add_foreign_key "user_activities", "users", name: "user_activities_user_id_fk"
  add_foreign_key "user_adjustments", "external_card_transfers", name: "user_adjustments_external_card_transfer_id_fk"
  add_foreign_key "user_adjustments", "user_adjustments", column: "related_user_adjustment_id", name: "user_adjustments_related_user_adjustment_id_fk"
  add_foreign_key "user_adjustments", "user_check_deposits", name: "user_adjustments_user_check_deposit_id_fk"
  add_foreign_key "user_adjustments", "user_deals", name: "user_deal_transactions_user_deal_id_fk"
  add_foreign_key "user_adjustments", "users", name: "user_deal_transactions_user_id_fk"
  add_foreign_key "user_bank_account_balance_histories", "user_bank_accounts"
  add_foreign_key "user_bank_account_balance_histories", "users"
  add_foreign_key "user_bank_accounts", "users", name: "user_bank_accounts_user_id_fk"
  add_foreign_key "user_biller_payments", "user_billers", name: "user_biller_payments_user_biller_id_fk"
  add_foreign_key "user_biller_payments", "users", name: "bill_payments_user_id_fk"
  add_foreign_key "user_billers", "users", name: "billers_user_id_fk"
  add_foreign_key "user_bot_conversations", "users", name: "user_bot_conversations_user_id_fk"
  add_foreign_key "user_bot_exchange_entities", "user_bot_exchanges", name: "user_bot_exchange_entities_user_bot_exchange_id_fk"
  add_foreign_key "user_bot_exchanges", "user_bot_conversations", name: "user_bot_exchanges_user_bot_conversation_id_fk"
  add_foreign_key "user_bot_exchanges", "user_bot_exchanges", column: "original_user_bot_exchange_id", name: "user_bot_exchanges_original_user_bot_exchange_id_fk"
  add_foreign_key "user_bot_exchanges", "users", name: "user_bot_exchanges_user_id_fk"
  add_foreign_key "user_calls", "users", name: "user_calls_user_id_fk"
  add_foreign_key "user_check_deposit_holds", "user_adjustments", name: "user_check_deposit_holds_user_adjustment_id_fk"
  add_foreign_key "user_check_deposit_holds", "user_check_deposits", name: "user_check_deposit_holds_user_check_deposit_id_fk"
  add_foreign_key "user_check_deposit_holds", "users", name: "user_check_deposit_holds_user_id_fk"
  add_foreign_key "user_check_deposits", "users", name: "user_check_deposits_user_id_fk"
  add_foreign_key "user_cohorts", "users", name: "user_cohorts_user_id_fk"
  add_foreign_key "user_connected_billers", "users", name: "user_connected_billers_user_id_fk"
  add_foreign_key "user_contact_requests", "user_contacts", name: "user_contact_requests_user_contact_id_fk"
  add_foreign_key "user_contact_transfers", "user_contacts", name: "user_contact_transfers_user_contact_id_fk"
  add_foreign_key "user_contact_transfers", "users", column: "recipient_id", name: "user_contact_transfers_recipient_id_fk"
  add_foreign_key "user_contact_transfers", "users", name: "user_contact_transfers_user_id_fk"
  add_foreign_key "user_contacts", "users", column: "contact_user_id", name: "user_contacts_contact_user_id_fk"
  add_foreign_key "user_contacts", "users", name: "user_contacts_user_id_fk"
  add_foreign_key "user_deals", "deals", name: "user_deals_deal_id_fk"
  add_foreign_key "user_deals", "users", name: "user_deals_user_id_fk"
  add_foreign_key "user_devices", "users", name: "user_devices_user_id_fk"
  add_foreign_key "user_dispute_claim_transactions", "user_dispute_claims", name: "user_dispute_tran_map_user_dispute_claim_id_fk"
  add_foreign_key "user_dispute_claims", "users", name: "user_dispute_transactions_user_id_fk"
  add_foreign_key "user_employers", "users"
  add_foreign_key "user_fraud_controls", "users", name: "user_fraud_controls_user_id_fk"
  add_foreign_key "user_invites", "refer_a_friend_campaigns", name: "user_invites_refer_a_friend_campaign_id_fk"
  add_foreign_key "user_invites", "users", name: "user_invites_user_id_fk"
  add_foreign_key "user_limits", "users", name: "ach_limits_user_id_fk"
  add_foreign_key "user_merchant_blocks", "merchants", name: "user_merchant_blocks_merchant_id_fk"
  add_foreign_key "user_merchant_blocks", "users", name: "user_merchant_blocks_user_id_fk"
  add_foreign_key "user_merchants", "merchants", name: "user_merchants_merchant_id_fk"
  add_foreign_key "user_merchants", "users", name: "user_merchants_user_id_fk"
  add_foreign_key "user_notifications", "notifications", name: "user_notifications_notification_id_fk"
  add_foreign_key "user_perks", "users"
  add_foreign_key "user_posted_transaction_locations", "transaction_locations", name: "user_posted_transaction_locations_transaction_location_id_fk"
  add_foreign_key "user_posted_transaction_locations", "users", name: "user_posted_transaction_locations_user_id_fk"
  add_foreign_key "user_queued_transactions", "user_adjustments", name: "user_queued_transactions_user_adjustment_id_fk"
  add_foreign_key "user_queued_transactions", "user_bank_accounts", name: "user_queued_transactions_user_bank_account_id_fk"
  add_foreign_key "user_queued_transactions", "users", name: "user_queued_transactions_user_id_fk"
  add_foreign_key "user_rewards", "users", name: "user_rewards_user_id_fk"
  add_foreign_key "user_roundup_bonus_eligibilities", "users", name: "user_roundup_bonus_eligibilities_user_id_fk"
  add_foreign_key "user_settings", "users", name: "user_settings_user_id_fk"
  add_foreign_key "user_store_review_prompts", "users", name: "user_store_review_prompts_user_id_fk"
  add_foreign_key "user_tokens", "users", name: "user_tokens_user_id_fk"
  add_foreign_key "user_transaction_details", "users", name: "user_transaction_details_user_id_fk"
  add_foreign_key "user_transaction_locations", "users", name: "user_transaction_locations_user_id_fk"
  add_foreign_key "users", "deals", column: "referral_deal_id", name: "users_referral_deal_id_fk"
  add_foreign_key "users", "refer_a_friend_campaigns", column: "weekly_roundup_bonus_multiple_raf_campaign_id", name: "users_weekly_roundup_bonus_multiple_raf_campaign_id_fk"
  add_foreign_key "users", "refer_a_friend_campaigns", name: "users_refer_a_friend_campaign_id_fk"
  add_foreign_key "vantiv_chargeback_win_losses", "users", name: "vantiv_chargeback_win_losses_user_id_fk"
  add_foreign_key "vantiv_chargebacks", "users", name: "vantiv_chargebacks_user_id_fk"
  add_foreign_key "vantiv_settled_sales", "users", name: "vantiv_settled_sales_user_id_fk"
  add_foreign_key "zendesk_priority_cohorts", "cohorts", column: "cohort_id_1", name: "zendesk_priority_cohorts_cohort_id_1_fk"
  add_foreign_key "zendesk_priority_cohorts", "cohorts", column: "cohort_id_2", name: "zendesk_priority_cohorts_cohort_id_2_fk"
  add_foreign_key "zendesk_priority_cohorts", "cohorts", column: "cohort_id_3", name: "zendesk_priority_cohorts_cohort_id_3_fk"
  add_foreign_key "zendesk_priority_cohorts", "cohorts", column: "cohort_id_4", name: "zendesk_priority_cohorts_cohort_id_4_fk"
  add_foreign_key "zendesk_priority_cohorts", "cohorts", column: "cohort_id_5", name: "zendesk_priority_cohorts_cohort_id_5_fk"
end
