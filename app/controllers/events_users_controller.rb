class EventsUsersController < ApplicationController
  def create
    user_params = event_user_params
    @eventuser = EventsUsers.new
    @eventuser.user_id = user_params.fetch(:user_id)
    @eventuser.event_id = user_params.fetch(:event_id)
    if @eventuser.user_id.nil? || @eventuser.event_id.nil?
      # TODO: add failure feedback
      redirect_back :fallback_location => '/events'
    else
      @eventuser.save
      render('events_users/success')
    end
  end

  private

  def event_user_params
    eventuser = params.require(:eventuser)
    eventuser.permit(:event_id, :user_id, :email)
    if eventuser.has_key?(:email) && !eventuser.has_key?(:user_id)
      eventuser[:user_id] = User.find_or_create_by(:email => eventuser[:email]).id
    end
    eventuser.delete(:email)
    eventuser
  end
end