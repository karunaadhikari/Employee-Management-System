# frozen_string_literal: true

class CreateEmpLeaveInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :emp_leave_infos do |t|
      t.text :reason
      t.references :leave_info, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.date :date_from
      t.date :date_to
      t.integer :status

      t.timestamps
    end
  end
end
