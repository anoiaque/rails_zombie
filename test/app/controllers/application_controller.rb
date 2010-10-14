require File.join(File.dirname(__FILE__), '../../../lib/rails_zombie')

class ApplicationController < ActionController::Base
  include RailsZombie
end