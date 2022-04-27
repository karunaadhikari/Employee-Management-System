# frozen_string_literal: true

ActiveAdmin.register Employee do
  permit_params :fname, :lname, :position, :gender, :join_date, :status, :email, :password

  form do |f|
    f.semantic_errors
    f.inputs :fname, :lname, :position, :gender, :join_date, :status, :email
    actions
  end

  before_create do |emp|
    emp.password = SecureRandom.hex(8)
  end
end
