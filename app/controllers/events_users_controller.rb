class EventsUsersController < ApplicationController
    def create
        @eventuser = EventsUsers.new(event_user_params)
    end

    private
        def event_user_params
            params.require(:eventuser).permit(:event_id, :user_id)
        end
end