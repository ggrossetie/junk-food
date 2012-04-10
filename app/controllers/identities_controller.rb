class IdentitiesController < ApplicationController
  skip_before_filter :require_login

  def new
    @identity = env['omniauth.identity']
    @view_name = "New account"
  end

  def show
  end
end
