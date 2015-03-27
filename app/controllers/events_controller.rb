class EventsController < ApplicationController

  #layout "simple"
  #可以換layout

  before_action :set_event, :only => [ :show, :edit, :update, :destroy]

  #GET /events
  def index
    # @events = Event.all
    @events = Event.page(params[:page]).per(5)

    @event = Event.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @events.to_xml }
      format.json { render :json => @events.to_json }
      format.atom { @feed_title = "My event list" } # index.atom.builder
    end

  end

  #GET /events/new
  def new
    @event = Event.new
  end
  #GET /events/123
  def show
    @page_title = @event.name #為了變更Application的tile用

    Rails.logger.debug("event: #{@event.inspect}")

    respond_to do |format|
      format.html { @page_title = @event.name } # show.html.erb
      format.xml # show.xml.builder
      format.json { render :json => { id: @event.id, name: @event.name }.to_json }
    end

  end
  #POST /events
  def create
    @event = Event.new( event_params )
    #代表我只要 :event這個key的值，且event_params定義在下面的protected內
    #同params[:event][:name]和params[:event][:description]
    # @event = Event.new( :name => params[:event][:name], :description => params[:event][:description])
    #代表我只要 :event這個key的值，原始寫法
    if @event.save
      flash[:notice] = "event was successfully created"
      redirect_to events_url #events_path也可以
    else
      flash[:other] = "create failed"
      render :action => :new #render :new也可以，省略:action
    end
  end
  #GET /events/123/edit
  def edit
  end
  #PATCH /events/123
  def update
    if @event.update( event_params )
      flash[:warning] = "event was successfully updated"
      # redirect_to :action => "index"
      redirect_to event_path(@event)
    else
      flash[:other] = "update failed"
      render :action => :edit
    end
  end
  #DELETE /events/123
  def destroy
    @event.destroy
    flash[:alert] = "event was successfully deleted"
    redirect_to :back
  end

  #strong parameter
  protected #or private
  def event_params
    params.require(:event).permit(:name, :description)
  end

  def set_event
    @event = Event.find(params[:id])
  end

end
