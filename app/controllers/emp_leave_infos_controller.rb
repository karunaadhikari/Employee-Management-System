# frozen_string_literal: true

class EmpLeaveInfosController < ApplicationController
  before_action :set_emp_leave_info, only: %i[show edit update destroy]
  before_action :require_permission, only: %i[edit update destroy show]
  def new
    @emp_leave_info = EmpLeaveInfo.new
  end

  def create
    @emp_leave_info = current_employee.emp_leave_infos.build(leave_params)
    if @emp_leave_info.save
      flash[:notice] = 'Your LEAVE APPLICATION is submitted!'
      redirect_to emp_leave_infos_path
    else
      flash[:alert] = 'YES, there has been an error'
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @emp_leave_infos = current_employee.emp_leave_infos.order('created_at DESC').page params[:page]
  end

  def show; end

  def edit; end

  def update
    @emp_leave_info.update(leave_params)
    if @emp_leave_info.save
      flash[:notice] = 'Your LEAVE APPLICATION has been updated!'
      redirect_to emp_leave_infos_path
    else
      flash[:alert] = 'YES, there has been an error'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @emp_leave_info.destroy
    flash[:notice] = 'The APPLICATION was successfully deleted!'
    redirect_to emp_leave_infos_path
  end

  private

  def leave_params
    params.require(:emp_leave_info).permit(:employee_id, :date_from, :date_to, :reason, :leave_info_id)
  end

  def require_permission
    return unless @emp_leave_info.employee != current_employee

    redirect_to root_path, flash: {alert: 'You do not have permission to do that'}
  end

  def set_emp_leave_info
    @emp_leave_info = EmpLeaveInfo.find(params[:id])
  end
end
