# frozen_string_literal: true

class ChangeDefaultDaysToIntToLeaveInfo < ActiveRecord::Migration[7.0]
  def up
    change_column :leave_infos, :default_days, 'int USING default_days::integer'
  end

  def down
    change_column :leave_infos, :default_days, :string
  end
end
