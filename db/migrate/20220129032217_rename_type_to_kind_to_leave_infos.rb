# frozen_string_literal: true

class RenameTypeToKindToLeaveInfos < ActiveRecord::Migration[7.0]
  def change
    rename_column :leave_infos, :type, :kind
  end
end
