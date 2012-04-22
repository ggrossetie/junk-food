class DashboardController < ApplicationController
  include ApplicationHelper

  def index
    @identity = Identity.find(current_user.uid) if current_user
    @foods = Food.all
    @view_name = "Dashboard"
    @operation = Operation.new
    @operations = Operation.limit(15).all(:order => :date.desc)

    @start_date = 1.week.ago.utc

    Struct.new("TopUser", :name, :email, :gravatar_img, :value)

    top_eater = Operation.collection.group(['user_id'],
                                           {:value => {"$lt" => 1}},
                                           {'sum' => 0},
                                           "function(doc, prev) { prev.sum += doc.value}").sort { |x, y| x["sum"] <=> y["sum"] }.first()
    if top_eater
      top_eater_identity = Identity.find(User.find(top_eater["user_id"]).uid)
      @top_eater_user = Struct::TopUser.new(top_eater_identity.name,
                                            top_eater_identity.email,
                                            gravatar(top_eater_identity.email, :size => 40).html_safe,
                                            top_eater["sum"])
    end

    top_contributor = Operation.collection.group(['user_id'],
                                                 {:value => {"$gte" => 1}},
                                                 {'sum' => 0},
                                                 "function(doc, prev) { prev.sum += doc.value}").sort { |x, y| y["sum"] <=> x["sum"] }.first()
    if top_contributor
      top_contributor_identity = Identity.find(User.find(top_contributor["user_id"]).uid)
      @top_contributor_user = Struct::TopUser.new(top_contributor_identity.name,
                                                  top_contributor_identity.email,
                                                  gravatar(top_contributor_identity.email, :size => 40).html_safe,
                                                  top_contributor["sum"])
    end
  end
end
