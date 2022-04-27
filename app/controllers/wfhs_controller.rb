# frozen_string_literal: true

class WfhsController < ApplicationController
  before_action :set_wfh, only: %i[show edit update destroy]
  before_action :require_permission, only: %i[edit update destroy show]
  def new
    @wfh = Wfh.new
  end

  def create
    @wfh = current_employee.wfhs.create(wfh_params)
    if @wfh.valid?
      flash[:notice] = 'Your WFH application is submitted!'
      redirect_to wfhs_path
    else
      flash[:alert] = 'Woops! Looks like there has been an error!'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @wfh.update(wfh_params)
    if @wfh.valid?
      flash[:notice] = 'Your WFH application has been updated!'
      redirect_to wfhs_path
    else
      flash[:alert] = 'Woops! Looks like there has been an error!'
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @wfhs = current_employee.wfhs.order('created_at DESC').page params[:page]
  end

  def show; end

  def destroy
    @wfh.destroy
    flash[:notice] = 'The application was successfully deleted!'
    redirect_to wfhs_path
  end

  private

  def require_permission
    return unless @wfh.employee != current_employee

    redirect_to root_path, flash: {alert: 'You do not have permission to do that.'}
  end

  def set_wfh
    @wfh = Wfh.find(params[:id])
  end

  def wfh_params
    params.require(:wfh).permit(:availability_from, :availability_to, :reason)
  end
end
