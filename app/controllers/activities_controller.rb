class ActivitiesController < ApplicationController
  def index
  	@activities = PublicActivity::Activity.order("created_at desc").where(owner_type: "User").having(defined?(trackable) == true)
  end
end
