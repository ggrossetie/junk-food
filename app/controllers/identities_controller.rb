class IdentitiesController < ApplicationController
  skip_before_filter :require_login

  def new
    @identity = env['omniauth.identity']
  end

  def show
  end
end
