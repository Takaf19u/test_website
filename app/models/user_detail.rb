class UserDetail < ApplicationRecord
  belongs_to :user
  has_one :user_notification, dependent: :destroy, inverse_of: :user_detail
  accepts_nested_attributes_for :user_notification
  VALID_PHONE_REGEX = /\A\d{10,11}\z/

  validates :company_name, :name, :phone_number, presence: true
  validates :phone_number, numericality: true,
                           format: { with: VALID_PHONE_REGEX, message: I18n.t("errors.messages.phone_number_format") }

  def format_phone_number
    phone_number.delete("-")
  end
end
