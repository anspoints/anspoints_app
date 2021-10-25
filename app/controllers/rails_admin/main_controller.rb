module RailsAdmin
    class MainController < RailsAdmin::ApplicationController
        before_action :authenticate_admin!
    end
end