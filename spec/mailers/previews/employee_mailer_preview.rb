# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/employee_mailer
class EmployeeMailerPreview < ActionMailer::Preview
  def send_welcome_email
    emp = Employee.first
    raw_token = SecureRandom.uuid
    EmployeeMailer.send_welcome_email(emp, raw_token)
  end
end
