class OperationsController < ApplicationController
  # GET /operations
  # GET /operations.json
  def index
    @operations = Operation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @operations }
    end
  end

  # GET /operations/1
  # GET /operations/1.json
  def show
    @operation = Operation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @operation }
    end
  end

  # GET /operations/new
  # GET /operations/new.json
  def new
    @operation = Operation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @operation }
    end
  end

  # GET /operations/1/edit
  def edit
    @operation = Operation.find(params[:id])
  end

  # POST /operations
  # POST /operations.json
  def create
    @operation = Operation.new(params[:operation])

    user = User.find(@operation.user_id)
    @operation.user = user;

    food = Food.find(@operation.food_id)
    @operation.food = food;

    @operation.date = Time.zone.now.to_datetime

    respond_to do |format|
      if @operation.save
        format.html { redirect_to dashboard_url, notice: 'Operation was successfully created.' }
        format.json { render json: @operation, status: :created, location: @operation }
      else
        format.html { redirect_to dashboard_url, notice: 'Failed to create operation !' }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /operations/1
  # PUT /operations/1.json
  def update
    @operation = Operation.find(params[:id])

    respond_to do |format|
      if @operation.update_attributes(params[:operation])
        format.html { redirect_to @operation, notice: 'Operation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1
  # DELETE /operations/1.json
  def destroy
    @operation = Operation.find(params[:id])
    @operation.destroy

    respond_to do |format|
      format.html { redirect_to operations_url }
      format.json { head :no_content }
    end
  end
end
