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

class Wfh < ApplicationRecord
  belongs_to :employee
  validates :availability_from, :availability_to, :reason, :status, presence: true

  enum status: {requested: 0, approved: 1, rejected: 2}

  scope :today_wfh, -> { where(availability_from: DateTime.now.all_day) }
end
