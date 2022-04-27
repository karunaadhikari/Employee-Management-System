# frozen_string_literal: true

class TodayLeavesController < ApplicationController
  def index
    @today_leaves = EmpLeaveInfo.today_leave
    @today_wfhs = Wfh.today_wfh
  end
end
