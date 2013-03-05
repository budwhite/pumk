class DeedsController < ApplicationController
  # GET /deeds
  # GET /deeds.json
  def index
    @deeds = Deed.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deeds }
    end
  end

  # GET /deeds/1
  # GET /deeds/1.json
  def show
    @deed = Deed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @deed }
    end
  end

  # GET /deeds/new
  # GET /deeds/new.json
  def new
    @deed = Deed.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @deed }
    end
  end

  # GET /deeds/1/edit
  def edit
    @deed = Deed.find(params[:id])
  end

  # POST /deeds
  # POST /deeds.json
  def create
    @deed = Deed.new(params[:deed])

    respond_to do |format|
      if @deed.save
        format.html { redirect_to @deed, notice: 'Deed was successfully created.' }
        format.json { render json: @deed, status: :created, location: @deed }
      else
        format.html { render action: "new" }
        format.json { render json: @deed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /deeds/1
  # PUT /deeds/1.json
  def update
    @deed = Deed.find(params[:id])

    respond_to do |format|
      if @deed.update_attributes(params[:deed])
        format.html { redirect_to @deed, notice: 'Deed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @deed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deeds/1
  # DELETE /deeds/1.json
  def destroy
    @deed = Deed.find(params[:id])
    @deed.destroy

    respond_to do |format|
      format.html { redirect_to deeds_url }
      format.json { head :no_content }
    end
  end
end
