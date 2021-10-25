module RailsAdmin
    class MainController < RailsAdmin::ApplicationController
        before_action :authenticate_user!

        def check_admin_authorization!
            render file: 'public/401.html', layout: false, status: :unauthorized unless current_user.isAdmin == true       
        end
    end
end