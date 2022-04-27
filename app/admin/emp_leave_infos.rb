# frozen_string_literal: true

ActiveAdmin.register EmpLeaveInfo, as: 'LeaveApplication' do
  scope :requested
  scope :approved
  scope :rejected

  permit_params :reason, :leave_info_id, :employee_id, :date_from, :date_to, :status

  action_item :leave_application, only: :show do
    link_to 'Approve', approve_admin_leave_application_path(leave_application), method: :put
  end

  member_action :approve, method: :put do
    leave_application = EmpLeaveInfo.find(params[:id])
    leave_application.approved!
    redirect_to admin_leave_application_path(leave_application), notice: 'Your application has been approved'
  end

  member_action :reject, method: :put do
    leave_application = EmpLeaveInfo.find(params[:id])
    leave_application.rejected!
    redirect_to admin_leave_application_path(leave_application), notice: 'Your application has been rejected'
  end

  action_item :leave_application, only: :show do
    link_to 'Reject', reject_admin_leave_application_path(leave_application), method: :put
  end
end
