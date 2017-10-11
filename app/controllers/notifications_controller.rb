class NotificationsController < ApplicationController
	before_action :set_notification, only: [:show, :update, :destroy]

  # GET /notifications
  def index
    if params[:question_id] != nil and params[:category] != nil
      @notifications = Notification.where("question_id = ? AND category = ?", params[:question_id], params[:category])
    elsif params[:category] != nil
      @notifications = Notification.where("category = ?", params[:category])
    elsif params[:question_id] != nil
      @notifications = Notification.where("question_id = ?", params[:question_id])
    else
      @notifications = Notification.all
    end
    json_response(@notifications)
  end

  # POST /notifications
  def create
    @notification = Notification.create!(notification_params)
    json_response(@notification, :created)
  end

  # GET /notifications/:id
  def show
    json_response(@notification)
  end

  # PUT /notifications/:id
  def update
    @notification.update(notification_params)
    head :no_content
  end

  # DELETE /notifications/:id
  def destroy
    @notification.destroy
    head :no_content
  end

  private

  def notification_params
    # whitelist params
    params.permit( :message, :category, :question_id, :url )
  end

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
