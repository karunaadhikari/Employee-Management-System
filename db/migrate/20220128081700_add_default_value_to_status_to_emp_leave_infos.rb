# frozen_string_literal: true

class AddDefaultValueToStatusToEmpLeaveInfos < ActiveRecord::Migration[7.0]
  def change
    change_column_default :emp_leave_infos, :status, from: nil, to: 0
  end
end
