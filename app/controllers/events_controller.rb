class EventsController < ApplicationController

  #layout "simple"
  #可以換layout

  before_action :set_event, :only => [ :show, :edit, :update, :destroy]

  #GET /events
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def show
    @page_title = @event.name #為了變更Application的tile用
  end

  def create
    @event = Event.new( event_params )
    #代表我只要 :event這個key的值，且event_params定義在下面的protected內
    #同params[:event][:name]和params[:event][:description]
    # @event = Event.new( :name => params[:event][:name], :description => params[:event][:description])
    #代表我只要 :event這個key的值，原始寫法
    if @event.save
      flash[:notice] = "event was successfully created"
      redirect_to :action => "index"
    else
      flash[:other] = "create failed"
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @event.update( event_params )
      flash[:warning] = "event was successfully updated"
      # redirect_to :action => "index"
      redirect_to :action => :show, :id => @event
    else
      flash[:other] = "update failed"
      render :action => :edit
    end
  end

  def destroy
    @event.destroy
    flash[:alert] = "event was successfully deleted"
    redirect_to :action => :index
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
