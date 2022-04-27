# == Schema Information
#
# Table name: employees
#
#  id                     :integer          not null, primary key
#  uid                    :string
#  fname                  :string
#  lname                  :string
#  position               :integer
#  gender                 :integer
#  join_date              :date
#  status                 :integer
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    uid { FFaker::Guid.guid }
    fname { FFaker::Name.unique.first_name }
    lname { FFaker::Name.unique.last_name }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    position { Employee.positions.keys.sample }
    gender { Employee.genders.keys.sample }
    join_date { FFaker::Time.date }
    status { Employee.statuses.keys.sample }
  end
end
