# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  country     :string
#  state       :string
#  district    :string
#  city        :string
#  street      :string
#  house_no    :string
#  employee_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  kind        :integer
#

# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    association :employee
    country { FFaker::Address.country }
    state { FFaker::AddressUS.state }
    district { FFaker::Address.secondary_address }
    city { FFaker::Address.city }
    street { FFaker::Address.street_name }
    house_no { FFaker::Address.building_number }
    sequence :kind, %i[temporary permanent].cycle
  end

  factory :invalid_address, parent: :address do
    country { nil }
  end
end
