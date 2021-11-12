# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def moon
    cookies[:moon] = 'true'
    redirect_back(fallback_location: root_path)
  end

  def sun
    cookies[:moon] = 'false'
    redirect_back(fallback_location: root_path)
  end
end
