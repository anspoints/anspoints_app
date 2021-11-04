# frozen_string_literal: true

class EventsController < ApplicationController
  # fetch the event immediately on these actions
  before_action :set_event, only: %i[qr join edit delete]

  ###########################
  ###### user endpoints #####
  ###########################

  # view all events
  def index
    # do not return the eventCode mainly
    columns = Event.attribute_names - ['eventCode']
    # Conversion to a naive time since the database stores local times without timezone info
    # RailsAdmin breaks if you try to use real Ruby/Rails timezone support
    now = Time.now.in_time_zone('Central Time (US & Canada)').change(offset: 0)
    today = now.to_date
    # now.. means in the range [now, infinity). You can interpret it as now-or-after (while ..now is before-to-now)
    all_events = Event.all.select(columns).order(date: :desc, startTime: :desc)
    @ongoing_events = all_events.where(date: today, startTime: [nil, ..now], endTime: [nil, now..])
    @upcoming_events = all_events.where(date: today, startTime: now..).or(all_events.where(date: (today + 1)..))
                                 .reorder(date: :asc, startTime: :asc)
    @past_events = all_events.where(date: today, endTime: ..now).or(all_events.where(date: ..(today - 1)))
    # @events = Event.where(date: today..)
    #                .and(Event.where(startTime: ..now).or(Event.where(startTime: nil)))
    #                .and(Event.where(endTime: now..).or(Event.where(endTime: nil)))
    #                .select(columns)
    #                .order(date: :asc, startTime: :asc)
    # @past_events = Event.where(date: ..(today - 1)).or(Event.where(date: today).and(Event.where(endTime: ..now)))
    #                     .select(columns)
    #                     .order(date: :desc, startTime: :desc)
  end

  def raw_qr
    # /qr/:code; bare-bones xhtml
    render inline: helpers.make_form(params[:code], request.host)
  end

  def qr
    # events/:id/qr, embeds raw_qr into a nice page while automatically retrieving the eventCode from the database
  end

  def join_by_code
    event = Event.find_by(eventCode: params[:event][:eventCode])
    if event.nil?
      # TODO: render this as a popup on the page
      # it would be cleaner to make the join method try to find the event
      # through several methods and allow it to end up nil
      redirect_to action: 'index', eventNotFound: true
    else
      redirect_to action: 'join', id: event.id
    end
  end

  def join
    # ask for a passcode
    respond_to do |format|
      format.html
      format.js
    end
    # show the form
  end

  ###########################
  ##### admin endpoints #####
  ###########################

  def new
    @event = Event.new
  end

  def edit; end

  def create
    @event = Event.new(event_params)
  end

  def delete
    @event.destroy
  end

  def show
    redirect_to controller: 'events', action: 'index'
  end

  #########################
  #### private methods ####
  #########################

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :eventCode, :eventTypeId, :description, :date, :startTime, :endTime,
                                  :price, :published_date)
  end
end
