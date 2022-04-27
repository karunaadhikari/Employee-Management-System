# frozen_string_literal: true

class CreateKycs < ActiveRecord::Migration[7.0]
  def change
    create_table :kycs do |t|
      t.string :phone
      t.date :dob
      t.integer :marital_status
      t.string :spouse_name
      t.string :spouse_phone
      t.string :spouse_email
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
