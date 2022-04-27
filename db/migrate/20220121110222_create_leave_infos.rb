# frozen_string_literal: true

class CreateLeaveInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :leave_infos do |t|
      t.string :uid
      t.integer :type
      t.string :default_days
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
