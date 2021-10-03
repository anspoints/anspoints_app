class EventsController < ApplicationController
    # fetch the event immediately on these actions
    before_action :set_event, only: %i[ join edit delete ]

    ###########################
    ###### user endpoints #####
    ###########################

    # view all events
    def index
        @events = Event.all
    end

    def join
        # ask for a passcode

        # show the form
    end

    def getEvents
        return Event.all
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
            params.require(:event).permit(:name, :eventCode, :eventTypeId, :description, :startTime, :endTime, :price, :published_date)
        end
end