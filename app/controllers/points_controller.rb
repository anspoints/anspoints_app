# frozen_string_literal: true

class PointsController < ActionController::Base
  def index
    # put any code here that you need
    # (although for a static view you probably won't have any)
    
    @event_types = EventTypes.select('"event_types"."name" as type')
    @event_points = Event.select('"events"."name" AS name, "event_types"."pointValue" AS point_val')
                         .joins('INNER JOIN "event_types" ON "events"."event_types_id" = "event_types"."id"')
                         .group('"events"."name", "event_types"."pointValue"')
    
    @event_types_array = Array.new
    @event_types.each do |category|
      @event_types_array.push(category.type)
    end

    @event_points_dict = {}
    @event_points.each do |event|
      @event_points_dict.merge!({event.name => event.point_val})
    end
    
    Rails.logger.debug @event_types_array
    Rails.logger.debug @event_points_dict

    if params[:sort] != 'count'
      @user_points_counts = EventsUsers.select('"users"."first_name" AS first_name, "users"."last_name" AS last_name, "users"."email" AS email, count(*) AS count')
                                       .joins('RIGHT JOIN "users" ON "events_users"."user_id" = "users"."id"')
                                       .group('"users"."first_name", "users"."last_name", "users"."email"').order('count DESC')

    elsif params[:sort] == 'count'
      @user_points_counts = EventsUsers.select('"users"."email" AS email, count(*) AS count')
                                       .joins('INNER JOIN "users" ON "events_users"."user_id" = "users"."id"')
                                       .group('"users"."email"').order('count DESC').reorder('count ASC')

    else
      @user_points_counts = EventsUsers.select('"users"."email" AS email, count(*) AS count')
                                       .joins('INNER JOIN "users" ON "events_users"."user_id" = "users"."id"')
                                       .group('"users"."email"')
    end
  end
end
