# frozen_string_literal: true

class LeaveInfosController < ApplicationController
  def index
    @leave_infos = LeaveInfo.all
  end
end
