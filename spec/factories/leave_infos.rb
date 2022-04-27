# == Schema Information
#
# Table name: leave_infos
#
#  id           :integer          not null, primary key
#  uid          :string
#  kind         :integer
#  default_days :integer
#  description  :text
#  status       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

# frozen_string_literal: true

FactoryBot.define do
  factory :leave_info do
    kind { LeaveInfo.kinds.keys.sample }
    default_days { rand(1..15) }
    description { FFaker::Tweet.body }
    status { LeaveInfo.statuses.keys.sample }
  end
end
