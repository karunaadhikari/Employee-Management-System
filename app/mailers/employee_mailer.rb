# frozen_string_literal: true

class EmployeeMailer < ApplicationMailer
  # send a signup email to the user, pass in the user object that contains the user's email address
  def send_welcome_email(employee, raw_token)
    # create reset password token
    @token = raw_token # raw
    @employee = employee
    mail(to: @employee.email, subject: 'Welcome To EMS.')
  end

  def send_leave_approval_mail(emp_leave_info)
    @employee = emp_leave_info.employee
    @emp_leave_info = emp_leave_info
    mail(to: @employee.email, subject: "Your application has been #{@emp_leave_info.status}")
  end

  def send_leave_application_request_to_admin(emp_leave_info)
    @emp_leave_info = emp_leave_info
    @employee = emp_leave_info.employee
    mail(to: '@admin@example.com',
         subject: 'Requested for leave',
         from: @employee.email.to_s)
  end
end
