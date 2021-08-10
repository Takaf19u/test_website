class UserDetail < ApplicationRecord
  belongs_to :user

  validates :company_name, :name, :phone_number, :user_id, presence: true
end
