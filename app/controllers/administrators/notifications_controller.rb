class Administrators::NotificationsController < ApplicationController
  layout "admin/application"
  before_action :authenticate_administrator!
  before_action :confirm_url?, only: [:show]

  def index
    @q = Notification.ransack(params[:q])
    @notices = @q.result(distinct: true).order(id: "DESC")
    @notices_count = @notices.size
    @select = params[:q].present? ? params[:q][:tag_cont] : ""
    @notices = @notices.page(params[:page]).per(10)
  end

  def new
    @notice = Notification.new
  end

  def confirm
    @notice = Notification.new(notice_params)
    return render :new if @notice.invalid?
  end

  def create
    @notice = Notification.new(notice_params)
    return render :new if params[:back]
    if @notice.save
      redirect_to notifications_path, flash: { notice: I18n.t("message.complete_notice") }
    else
      render :new
    end
  end

  def show
    @notice = Notification.find(params[:id])
  end


  def destroy
    notice = Notification.find(params[:id])
    notice.destroy
    redirect_to notifications_path, flash: { message: I18n.t("message.delete_success") }
  end

  private

  def notice_params
    params.require(:notification).permit(:title, :content, :tag).merge(administrator_id: current_administrator.id)
  end

  def confirm_url?
    return redirect_to new_notification_path if params[:id].eql?("confirm")
  end
end
