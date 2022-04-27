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

require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:emp_1) { create(:employee) }

  # Basic Validations
  describe 'validations' do
    it { should validate_presence_of(:fname) }
    it { should validate_presence_of(:lname) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

    # Foreign Relations
    it { should have_many(:addresses) }
    it { should have_one(:kyc) }
    it { should have_many(:emp_leave_infos) }
    it { should have_many(:wfhs) }

    it 'is valid with valid attributes' do
      expect(emp_1).to be_valid
    end
  end

  describe 'one_of_the_following' do
    # Gender has to be one of the following:
    it do
      expect(emp_1).to define_enum_for(:gender).with_values(male: 0, female: 1, other: 2)
    end

    # Position has to be one of the following:
    it do
      expect(emp_1).to define_enum_for(:position).with_values(intern: 0, junior: 1, associate: 2, senior: 3, principal: 4)
    end

    # Status has to be one of the following:
    it do
      expect(emp_1).to define_enum_for(:status).with_values(active: 0, inactive: 1)
    end
  end

  describe 'full_name' do
    it 'returns first name and last name' do
      expect(emp_1.full_name).to eq("#{emp_1.fname} #{emp_1.lname}")
    end
  end
end
