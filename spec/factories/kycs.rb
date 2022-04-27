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

FactoryBot.define do
  factory :kyc do
    association :employee
    phone { FFaker::PhoneNumber.short_phone_number }
    dob { FFaker::Time.date }
    marital_status { Kyc.marital_statuses.keys.sample }
    spouse_name { FFaker::Name.unique.name }
    spouse_phone { FFaker::PhoneNumber.short_phone_number }
    spouse_email { FFaker::Internet.email }
    status { Kyc.statuses.keys.sample }
  end

  factory :today_birthdays, parent: :kyc do
    dob { "#{FFaker::Vehicle.year}/#{Time.zone.today.month}/#{Time.zone.today.day}" }
  end
end
