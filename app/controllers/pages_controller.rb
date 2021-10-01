class PagesController < ApplicationController
    def home
        @isAdmin = false
         # check for admin here
        @links = [["Events", "#events-div"], ["Points", "#points-div"], ["Contacts", "#contacts-div"]]
    end
end