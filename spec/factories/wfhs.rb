# == Schema Information
#
# Table name: wfhs
#
#  id                :integer          not null, primary key
#  employee_id       :integer          not null
#  availability_from :datetime
#  availability_to   :time
#  reason            :text
#  status            :integer          default("0")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

# frozen_string_literal: true

date = DateTime.now.beginning_of_day
FactoryBot.define do
  factory :wfh do
    association :employee
    availability_from { date }
    availability_to { date }
    reason { FFaker::Tweet.body }
    status { Wfh.statuses.keys.sample }
  end

  factory :invalid_wfh, parent: :wfh do
    availability_from { nil }
  end

  factory :today_wfh_emp, parent: :wfh do
    availability_from { date }
  end
end
