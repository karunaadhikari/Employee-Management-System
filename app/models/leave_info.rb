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

class LeaveInfo < ApplicationRecord
  has_many :emp_leave_infos, dependent: :restrict_with_error
  validates :kind, :default_days, :description, :status, presence: true

  enum status: {inactive: 0, active: 1}
  enum kind: {sick: 0, paid: 1, maternity: 2, paternity: 3, kriya: 4, other: 5}

  def title
    kind
  end
end
