# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_employee!
  layout :set_layout

  def set_layout
    'dashboard' if employee_signed_in?
  end
end
