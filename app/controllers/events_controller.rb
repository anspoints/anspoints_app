# frozen_string_literal: true

class EventsController < ApplicationController
  # fetch the event immediately on these actions
  skip_before_action :verify_authenticity_token, only: [:join_by_code]
  before_action :set_event, only: %i[qr join edit delete]

  ###########################
  ###### user endpoints #####
  ###########################

  # view all events
  def index
    # do not return the eventCode or ID because putting those into the view would bypass their intended exclusivity
    columns = Event.attribute_names - %w[eventCode id]
    @ongoing_events = Event.ongoing.select(columns)
    @upcoming_events = Event.upcoming.select(columns)
    @past_events = Event.past.select(columns)
  end

  def raw_qr
    # /qr/:code; bare-bones xhtml
    render inline: helpers.make_form(params[:code], request.host)
  end

  def qr
    # events/:id/qr, embeds raw_qr into a nice page while automatically retrieving the eventCode from the database
  end

  def join_by_code
    code = params[:event][:eventCode]
    event = Event.from_code(code)
    if event.nil?
      # it would be cleaner to make the join method try to find the event
      # through several methods and allow it to end up nil
      flash[:error] = "No event was found with the event code #{code}."
      redirect_to action: 'index'
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
