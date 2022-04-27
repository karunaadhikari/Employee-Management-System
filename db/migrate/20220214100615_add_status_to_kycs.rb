# frozen_string_literal: true

class AddStatusToKycs < ActiveRecord::Migration[7.0]
  def change
    add_column :kycs, :status, :integer, default: 0
  end
end
