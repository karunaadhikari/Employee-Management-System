# == Schema Information
#
# Table name: emp_leave_infos
#
#  id            :integer          not null, primary key
#  reason        :text
#  leave_info_id :integer          not null
#  employee_id   :integer          not null
#  date_from     :date
#  date_to       :date
#  status        :integer          default("0")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# frozen_string_literal: true

date = Time.zone.today
FactoryBot.define do
  factory :emp_leave_info do
    association :employee
    association :leave_info
    reason { FFaker::Tweet.body }
    date_from { date }
    date_to { date + 2 }
    status { EmpLeaveInfo.statuses.keys.sample }
  end

  factory :invalid_emp_leave_info, parent: :emp_leave_info do
    date_from { nil }
  end

  factory :today_leave_emp, parent: :emp_leave_info do
    date_from { date }
  end
end
