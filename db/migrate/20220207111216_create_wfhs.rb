# frozen_string_literal: true

class CreateWfhs < ActiveRecord::Migration[7.0]
  def change
    create_table :wfhs do |t|
      t.references :employee, null: false, foreign_key: true
      t.datetime :availability_from
      t.datetime :availability_to
      t.text :reason
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
