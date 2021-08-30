class Users::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Notification.ransack(params[:q])
    tags = Notification.select_notifications(current_user)
    @notices = Notification.search_notifications(tags, @q)
    @notices_count = @notices.size
    @notices = @notices.page(params[:page]).per(10)
  end

  def show
    @notice = Notification.find(params[:id])
  end
end
