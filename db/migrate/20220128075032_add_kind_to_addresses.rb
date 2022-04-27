# frozen_string_literal: true

class AddKindToAddresses < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :kind, :integer
  end
end
