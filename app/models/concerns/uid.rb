# frozen_string_literal: true

module Uid
  extend ActiveSupport::Concern

  included do
    before_validation :generate_uuid

    validates :uid, presence: true, uniqueness: true

    def generate_uuid
      return if uid.present?

      uuid = SecureRandom.uuid
      generate_uuid if self.class.exists?(uid: uuid)
      self.uid = uuid
    end
  end
end
