# frozen_string_literal: true

class UsersController < ApplicationController
  # fetch the event immediately on these actions
  before_action :set_user, only: %i[edit delete]

  ###########################
  ###### user endpoints #####
  ###########################

  def search
    input = params[:input]
    return if input.nil?

    logger.info(input)
    @searcheduser = User.all.where('"users"."email" = ?', input).first
    return if @searcheduser.nil?

    @pointscount = EventsUsers.all.where('"events_users"."user_id" = ?', @searcheduser.id).count
  end

  def show; end

  ###########################
  ##### admin endpoints #####
  ###########################

  # view all users
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
  end

  def delete
    @user.destroy
  end

  #########################
  #### private methods ####
  #########################

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:netId, :userDetailsId, :isAdmin)
  end
end
