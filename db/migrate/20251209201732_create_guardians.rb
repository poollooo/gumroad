# frozen_string_literal: true

class CreateGuardians < ActiveRecord::Migration[7.1]
  def change
    create_table :guardians do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.date :date_of_birth, null: false

      t.string :street_address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip_code, null: false
      t.string :country, null: false
      t.string :country_code

      t.binary :individual_tax_id

      t.string :stripe_person_id
      t.boolean :stripe_tos_accepted, default: false
      t.string :stripe_tos_ip
      t.boolean :stripe_processing_tos_accepted, default: false
      t.string :stripe_identity_document_id
      t.string :stripe_additional_document_id

      t.string :job_title

      t.string :nationality

      t.string :first_name_kanji
      t.string :last_name_kanji
      t.string :first_name_kana
      t.string :last_name_kana
      t.string :building_number
      t.string :street_address_kanji
      t.string :street_address_kana

      t.timestamps
    end

    add_index :guardians, :stripe_person_id, unique: true
  end
end
