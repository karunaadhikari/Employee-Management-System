# == Schema Information
#
# Table name: kycs
#
#  id             :integer          not null, primary key
#  phone          :string
#  dob            :date
#  marital_status :integer
#  spouse_name    :string
#  spouse_phone   :string
#  spouse_email   :string
#  employee_id    :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :integer          default("0")
#

# frozen_string_literal: true

class Kyc < ApplicationRecord
  belongs_to :employee
  validates :phone, :dob, :marital_status, presence: true
  validates :spouse_name, presence: true, if: :married?
  scope :today_birthdays, -> {
                            where('EXTRACT(month FROM dob) = ? AND EXTRACT(day FROM dob) = ?',
                                  Time.zone.today.month, Time.zone.today.day)
                          }

  enum marital_status: {single: 0, married: 1, divorced: 2, widowed: 3}
  enum status: {requested: 0, approved: 1, rejected: 2}

  def upcoming_birthday
    year = Time.zone.today.year
    mmdd = dob.strftime('%m%d')
    year += 1 if mmdd < Time.zone.today.strftime('%m%d')
    mmdd = '0302' if mmdd == '0229' && !Date.parse("#{year}0101").leap?
    Date.parse("#{year}#{mmdd}")
  end

  private

  def married?
    marital_status == 'married'
  end
end
