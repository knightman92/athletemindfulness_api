module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
  def check_user
    if current_coach
      # if you have rails_admin. You can redirect anywhere really
      redirect_to(rails_coach.dashboard_path) && return
    elsif current_player
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to(authenticated_player_root_path) && return
    end
  end
end