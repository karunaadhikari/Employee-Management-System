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

class Address < ApplicationRecord
  belongs_to :employee

  validates :country, :state, :district, :city, :street, :kind, presence: true
  validates :kind, uniqueness: {case_sensitive: true}

  enum kind: {temporary: 0, permanent: 1}
end
