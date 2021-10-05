class ContactsController < ApplicationController
    # fetch the event immediately on these actions
    before_action :set_contact, only: %i[ show edit delete ]

    ###########################
    ###### user endpoints #####
    ###########################

    # view all events
    def index
        @contacts = Contact.all
    end

    ###########################
    ##### admin endpoints #####
    ###########################

    def new
        @contact = Contact.new
    end

    def edit
        
    end

    def create
        @contact = Contact.new(contact_params)
    end

    def delete
        @contact.destroy
    end

    def show
    end

    #########################
    #### private methods ####
    #########################

    private
        def set_contact
            @contact = Contact.find(params[:id])
        end

        def contact_params
            params.require(:contact).permit(:firstname, :lastname, :title, :bio, :affiliation, :email)
        end
end