# frozen_string_literal: true

class AddUniquenessToKindToAddress < ActiveRecord::Migration[7.0]
  def change
    add_index :addresses, :kind, unique: true
  end
end
