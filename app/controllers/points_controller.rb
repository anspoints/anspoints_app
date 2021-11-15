# frozen_string_literal: true

class PointsController < ActionController::Base
  def index
    # put any code here that you need
    # (although for a static view you probably won't have any)
    
    @event_types = Event.select('"events"."id" AS event_id, "event_types"."name" AS event_type')
                        .joins('INNER JOIN "event_types" ON "events"."event_types_id" = "event_types"."id"')
                        .group('"events"."id", "event_types"."name"')
    @event_types_dict = {}
    @event_types.each do |event|
      @event_types_dict.merge!({event.event_id => event.event_type})
    end
    Rails.logger.debug @event_types_dict

    @type_points = EventTypes.select('DISTINCT "event_types"."name" AS name, "event_types"."pointValue" AS point_val')
    @type_points_dict = {}
    @type_points.each do |type|
      @type_points_dict.merge!({type.name => type.point_val})
    end
    Rails.logger.debug @type_points_dict

    @user_details = User.select('DISTINCT "users"."id" AS userid, "users"."first_name" AS first_name, "users"."last_name" AS last_name, "users"."email" AS email')
    @user_details_dict = {}
    @user_details.each do |user|
      @user_details_dict.merge!({user.userid => [user.first_name, user.last_name, user.email]})
    end
    Rails.logger.debug @user_details_dict

    @event_users = EventsUsers.select('"events_users"."user_id" AS userid, "events_users"."event_id" AS eventid')
    @event_users_array = Array.new
    @event_users.each do |record|
      @event_users_array.push([record.userid, record.eventid])
    end
    Rails.logger.debug @event_users_array

    @point_map = {}
    @type_points_dict.keys.each do |type|
      @point_map[type] = 0
    end
    Rails.logger.debug @point_map

    @user_points_dict = {}
    @event_users_array.each do |user, event|
      @type = @event_types_dict[event] #event type for event id
      #p "TYPE:  #{@type}"
      @points = @type_points_dict[@type] #point value of event type
      #p "POINTS: #{@points}"
      if(@user_points_dict.has_key?(user)) #if user is already in map
        if(@user_points_dict[user].has_key?(@type)) #check if event type for user already in map
          @user_points_dict[user][@type] += @points #add point value to total for that category
        else
          @user_points_dict[user].merge!({@type => @points}) #create mapping for new category found
        end
      else
        @point_map = {}
        @type_points_dict.keys.each do |type|
          @point_map[type] = 0
        end
        @point_map["Total"] = 0
        Rails.logger.debug @point_map
        @user_points_dict[user] = @point_map
        @user_points_dict[user].merge!({@type => @points})
      end
      @total = 0
      @user_points_dict[user].each do |category, points|
        Rails.logger.debug category
        Rails.logger.debug points
        if(category != "Total")
          @total += points #add total points from each event type
        end
      end
      @user_points_dict[user].merge!({"Total" => @total})
    end
    Rails.logger.debug @user_points_dict

    @user_details_dict.keys.each do |userid|
      if(!@user_points_dict.has_key?(userid))
        @point_map = {}
        @type_points_dict.keys.each do |type|
          @point_map[type] = 0
        end          
        @point_map["Total"] = 0
        @user_points_dict[userid] = @point_map
      end
    end
    Rails.logger.debug @user_points_dict

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
