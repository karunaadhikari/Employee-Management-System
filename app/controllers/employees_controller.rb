# frozen_string_literal: true

class EmployeesController < ApplicationController
  def index
    @employees = if params[:term]
                   Employee.filter_by_name(params[:term]).page(params[:page])

                 else
                   Employee.page(params[:page])
                 end
  end

  def show
    @employee = Employee.find(params[:id])
    @kyc = @employee.kyc if @employee.kyc.present?
  end
end
