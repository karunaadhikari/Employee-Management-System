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

class EmpLeaveInfo < ApplicationRecord
  belongs_to :leave_info
  belongs_to :employee

  scope :today_leave, -> { where('? BETWEEN date_from AND date_to', Time.zone.today) }

  validates :reason, :date_from, :status, presence: true

  enum status: {requested: 0, approved: 1, rejected: 2}

  after_commit :send_emp_leave_info_status_mail_to_employee, on: :update, if: :saved_change_to_status?

  after_commit :send_emp_leave_info_status_email_to_admin, on: :create

  private

  def send_emp_leave_info_status_mail_to_employee
    EmployeeMailer.send_leave_approval_mail(self).deliver if approved? || rejected?
  end

  def send_emp_leave_info_status_email_to_admin
    EmployeeMailer.send_leave_application_request_to_admin(self).deliver
  end
end
