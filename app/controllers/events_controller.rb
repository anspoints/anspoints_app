# frozen_string_literal: true

class EventsController < ApplicationController
  # fetch the event immediately on these actions
  before_action :set_event, only: %i[qr join edit delete]
  skip_before_action :verify_authenticity_token, only: [:join_by_code]

  ###########################
  ###### user endpoints #####
  ###########################

  # view all events
  def index
    # do not return the eventCode mainly
    @pastevents = Event.select(:id, :name, :date, :startTime, :endTime, :description)
                       .where('"events"."date" < ? and ("events"."endTime" is null or "events"."endTime" < ?)',
                              Date.today, Time.current)
                       .order(date: :asc, startTime: :asc)
    @events = Event.select(:id, :name, :date, :startTime, :endTime, :description)
                   .where('"events"."date" >= ? and ("events"."endTime" is null or "events"."endTime" <= ?)',
                          Date.today, Time.current)
                   .order(date: :asc, startTime: :asc)
  end

  def raw_qr
    # /qr/:code; bare-bones xhtml
    render inline: helpers.make_form(params[:code])
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
