class Notification < ApplicationRecord
  enum tag: [ :job, :other ]

  belongs_to :administrator

  validates :title, :content, :tag, presence: true
  validates :title, length: { maximum: 30 }
  validates :content, length: { maximum: 500 }
  validates :tag, correct_tag: true


  class << self
    def select_notifications(user)
      where_val = []
      notification = user.user_detail.user_notification
      tags.each_key do |k|
        where_val << k if notification[k]
      end
      where_val
    end

    def search_notifications(tags, q)
      return none if tags.blank?
      q.result(distinct: true).where(tag: tags).order(id: "DESC")
    end
  end
end
