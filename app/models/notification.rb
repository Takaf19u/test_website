class Notification < ApplicationRecord
  enum tag: [ :job, :other ]

  belongs_to :administrator

  validates :title, :content, :tag, presence: true
  validates :title, length: { maximum: 30 }
  validates :content, length: { maximum: 500 }
  validates :tag, correct_tag: true
end
