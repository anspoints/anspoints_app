# frozen_string_literal: true

RailsAdmin.config do |config|
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  if Rails.env.production?
    config.authenticate_with do
      warden.authenticate! scope: :user
    end
    config.current_user_method(&:current_user)

    RailsAdmin.config do |config|
      config.authorize_with do
        unless current_user.isAdmin
          flash[:error] = "#{current_user.email} is not an admin! Please try again with a different user
            or contact an administrator."
          User.find(current_user.id).destroy unless current_user.last_name != 'lastAdmin'
          redirect_to '/users/sessions/failed'
        end
      end
    end
  end

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard # mandatory
    index # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    member :qr_code do
      action_name :qr_code
      link_icon 'icon-qrcode'
      only Event
      controller do
        proc do
          redirect_to "/events/#{@object.id}/qr"
        end
      end
    end

    collection :import do
      action_name :import
      link_icon 'icon-upload'
      only User
    end

    root :wiki do
      action_name :wiki
      link_icon 'icon-book'
      controller do
        proc do
          redirect_to 'https://github.com/anspoints/anspoints_app/wiki/Admin-Manual'
        end
      end
    end

    root :points do
      action_name :points
      link_icon 'icon-user'
      show_in_navigation false
      show_in_sidebar true
      show_in_menu false
      sidebar_label 'Reports'
      controller do
        proc do
          redirect_to '/points'
        end
      end
    end

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
