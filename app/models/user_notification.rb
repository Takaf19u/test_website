class UserNotification < ApplicationRecord
  belongs_to :user_detail, inverse_of: :user_notification

  validates :other, :job, presence: true, on: :notice
end
