class UsersController < ApplicationController
    # fetch the event immediately on these actions
    before_action :set_user, only: %i[ edit delete ]

    ###########################
    ###### user endpoints #####
    ###########################

    def search
        input = params[:input]
        if input != nil
            logger.info(input)
            if input.match(/\A[a-z0-9\+\-_\.]+@[a-z\d\-.]+\.[a-z]+\z/i)
                @searcheduser = User.all.where('"users"."email" = ?', input).first
            else
                @searcheduser = User.all.where('"users"."netId" = ?', input).first
            end
            if @searcheduser != nil
                @pointsCount = UserEventLinks.all.where('"usereventlinks"."userId" = ?', @searcheduser.id).count
            end
        end
    end

    def show
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

        def user_params
            params.require(:user).permit(:netId, :userDetailsId, :isAdmin)
        end
end