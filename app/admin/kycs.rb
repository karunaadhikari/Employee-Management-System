# frozen_string_literal: true

ActiveAdmin.register Kyc do
  permit_params :phone, :dob, :marital_status, :spouse_name, :spouse_phone, :spouse_email, :status, :employee_id

  action_item :kyc, only: :show do
    link_to 'Approve', approve_admin_kyc_path(kyc), method: :put unless kyc.approved?
  end

  action_item :kyc, only: :show do
    link_to 'Reject', reject_admin_kyc_path(kyc), method: :put unless kyc.rejected?
  end

  member_action :approve, method: :put do
    kyc = Kyc.find(params[:id])
    kyc.approved!
    redirect_to admin_kyc_path(kyc), notice: 'Kyc status changed to approved!'
  end

  member_action :reject, method: :put do
    kyc = Kyc.find(params[:id])
    kyc.rejected!
    redirect_to admin_kyc_path(kyc), notice: 'Kyc status changed to rejected!'
  end

  form do |f|
    f.semantic_errors
    f.inputs :employee, :phone, :dob, :marital_status, :spouse_name, :spouse_phone, :spouse_email
    actions
  end
end
