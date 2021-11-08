# frozen_string_literal: true

class EventsUsersController < ApplicationController
  def create
    begin
      user_params = event_user_params
      user_params.require(%i[user_id event_id])
    rescue ActionController::ParameterMissing
      flash[:error] = 'Could not check in with the provided information. Please ensure all fields are filled in.'
      redirect_back fallback_location: '/events'
      return
    end
    if EventsUsers.exists?(event_id: user_params[:event_id], user_id: user_params[:user_id])
      # Already checked in
      render('events_users/success')
    else
      @eventuser = EventsUsers.new(event_id: user_params[:event_id], user_id: user_params[:user_id])
      if @eventuser.valid?
        @eventuser.save
        render('events_users/success')
      else
        flash[:error] = 'Could not check in with the provided information. Please ensure all fields are filled in.'
        redirect_back fallback_location: '/events'
      end
    end
  end

  def success; end

  def show
    redirect_to controller: 'events_users', action: 'success'
  end

  private

  def event_user_params
    # Validates parameters, converts email to ID, and updates name records before passing on user ID and event ID
    event_user = params.require(:eventuser)
    event_user.permit(:event_id, :user_id, :email, :first_name, :last_name)
    event_user.require(%i[event_id first_name last_name])

    user = if event_user.key?(:user_id)
             User.find(event_user[:user_id])
           else
             User.find_or_initialize_by(email: event_user.require(:email).downcase)
           end

    # Update name in case it is outdated
    first_name = event_user.delete(:first_name).titleize
    last_name = event_user.delete(:last_name).titleize
    user.update(first_name: first_name, last_name: last_name)
    user.save
    event_user[:user_id] = user.id

    event_user.require(%i[user_id])

    event_user.delete(:email)

    event_user
  end
end
