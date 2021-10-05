# frozen_string_literal: true

class PointsController < ActionController::Base
  def index
    # put any code here that you need
    # (although for a static view you probably won't have any)
    @user_points_counts = EventsUsers.select('"users"."email" AS email, count(*) AS count')
                                     .joins('INNER JOIN "users" ON "events_users"."user_id" = "users"."id"')
                                     .group('"users"."email"')
  end
end
