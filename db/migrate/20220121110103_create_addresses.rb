# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :state
      t.string :district
      t.string :city
      t.string :street
      t.string :house_no
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
