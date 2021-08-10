class UserInformation < ApplicationRecord
  belongs_to :user

  validates :company_name, :name, :number, :user_id, presence: true
end
