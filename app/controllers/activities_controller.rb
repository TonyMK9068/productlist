class ActivitiesController < ApplicationController
  def index
    if params[:scope] == 'friends'
      activities = PublicActivity::Activity.order("created_at desc").where(owner_type: "User").where(owner_id: current_user.friends).all
      @activities = []
      @activities = activities.collect do |activity| 
        if activity.trackable.public?
          activity
        end
      end
    else
  	  @activities = PublicActivity::Activity.order("created_at desc").where(owner_type: "User").all
    end
  end
end
