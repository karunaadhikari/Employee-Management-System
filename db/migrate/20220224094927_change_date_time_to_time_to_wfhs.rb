# frozen_string_literal: true

class ChangeDateTimeToTimeToWfhs < ActiveRecord::Migration[7.0]
  def up
    change_column :wfhs, :availability_to, :time
  end
end
