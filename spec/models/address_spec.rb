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

require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:emp_1) { create(:employee) }
  let(:add_1) { create(:address, employee_id: emp_1.id) }

  # Basic Validations
  describe 'validations' do
    subject { build(:address) }

    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:district) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:kind) }
    it { should validate_uniqueness_of(:kind).ignoring_case_sensitivity }
    it { should belong_to(:employee) }

    it 'is valid with valid attributes' do
      expect(add_1).to be_valid
    end

    describe 'one_of_the_following' do
      # Address has to be one of the following:
      it do
        expect(add_1).to define_enum_for(:kind).with_values(temporary: 0, permanent: 1)
      end
    end
  end
end
