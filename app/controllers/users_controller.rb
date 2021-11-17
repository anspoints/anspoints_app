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
    @searched_user = User.all.where('"users"."email" = ?', input).first
    return if @searched_user.nil?

    @points_count = @searched_user.count_points
    @events = @searched_user.events.order(date: :desc)
  end

  def show
    redirect_to controller: 'users', action: 'search'
  end

  def import
    # noinspection RubyMismatchedParameterType
    csv = CSV.new(params.require(:file).open, headers: true)
    csv.each do |row|
      # puts row.to_s
      next if row[0].nil? || row[0].empty? || row[1].nil? || row[1].empty?

      name = row[0]
      name = name.delete_prefix('Mr. ').delete_prefix('Mrs. ').delete_prefix('Miss ').delete_prefix('Dr. ')
      last_name = name.split.last
      first_name = name.chomp(" #{last_name}")
      email = row[1]
      user = User.create_with(first_name: first_name, last_name: last_name).create_or_find_by(email: email)
      user.update(dues_paid: true)
    end
    flash[:success] = 'Imported CSV successfully.'
    redirect_back fallback_location: '/admin/user/import'
  end

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
