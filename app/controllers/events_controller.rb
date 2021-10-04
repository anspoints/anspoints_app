class EventsController < ApplicationController
    # fetch the event immediately on these actions
    before_action :set_event, only: %i[ join edit delete ]

    ###########################
    ###### user endpoints #####
    ###########################

    # view all events
    def index
        # do not return the eventCode mainly
        @pastevents = Event.select(:id, :name, :date, :startTime, :endTime, :description)
            .where('"events"."date" < ? and ("events"."endTime" is null or "events"."endTime" < ?)', Date.today, Time.current())
            .order(date: :asc, startTime: :asc)
        @events = Event.select(:id, :name, :date, :startTime, :endTime, :description)
            .where('"events"."date" >= ? and ("events"."endTime" is null or "events"."endTime" <= ?)', Date.today, Time.current())
            .order(date: :asc, startTime: :asc)
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

    def edit
        
    end

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
            params.require(:event).permit(:name, :eventCode, :eventTypeId, :description, :date, :startTime, :endTime, :price, :published_date)
        end
end