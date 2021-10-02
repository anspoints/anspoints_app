class UsersController < ApplicationController
    # fetch the event immediately on these actions
    before_action :set_event, only: %i[ join edit delete ]

    ###########################
    ###### user endpoints #####
    ###########################

    def searchForm
        redirect_to "users/user_search"
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

    def edit
        
    end

    def create
        @user= User.new(user_params)
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

        def contact_params
            params.require(:user).permit(:netId, :userDetailsId, :isAdmin)
        end
end