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

class Employee < ApplicationRecord
  include Uid
  has_many :addresses, dependent: :destroy
  has_many :emp_leave_infos, dependent: :destroy
  has_many :wfhs, dependent: :destroy
  has_one :kyc, dependent: :destroy
  after_commit :send_welcome_message, on: :create

  validates :fname, :lname, :email, :gender, :position, :status, :password, presence: true
  validates :email, uniqueness: true
  validates :fname, :lname, :email, :gender, :position, :status, :password, presence: true
  validates :email, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  enum gender: {male: 0, female: 1, other: 2}
  enum position: {intern: 0, junior: 1, associate: 2, senior: 3, principal: 4}
  enum status: {active: 0, inactive: 1}

  scope :filter_by_name, ->(search_term) { where(['fname ILIKE ? or lname ILIKE ?', search_term, search_term]) }

  def full_name
    "#{fname} #{lname}"
  end

  private

  def send_welcome_message
    raw_token = create_reset_password_token
    EmployeeMailer.send_welcome_email(self, raw_token).deliver_later if valid?
  end

  def create_reset_password_token
    raw, hashed = Devise.token_generator.generate(self.class, :reset_password_token)
    self.reset_password_token = hashed
    self.reset_password_sent_at = Time.now.utc
    save
    raw
  end
end
