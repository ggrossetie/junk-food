class DashboardController < ApplicationController
  include ApplicationHelper

  def index
    @identity = Identity.find(current_user.uid) if current_user
    @foods = Food.all
    @view_name = "Dashboard"
    @operation = Operation.new
    @operations = Operation.all(:order => :date.desc)
  end
end
