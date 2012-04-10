class DashboardController < ApplicationController
  include ApplicationHelper 

  def index
    @identity = Identity.find(current_user.uid) if current_user
    @foods = Food.all
    @view_name = "Dashboard"
    @operation = Operation.new
    @operations = Operation.all(:order => :date.desc)
    #@gravatar_small = gravatar(identity.email, {:size => 20}).html_safe if identity
  end
end
