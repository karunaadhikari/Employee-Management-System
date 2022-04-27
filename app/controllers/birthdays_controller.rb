# frozen_string_literal: true

class BirthdaysController < ApplicationController
  def index
    @upcoming_birthdays = Kyc.all.sort_by(&:upcoming_birthday)
    @today_birthdays = Kyc.today_birthdays.all
  end
end
