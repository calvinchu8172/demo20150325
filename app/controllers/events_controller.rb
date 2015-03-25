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
    @event.name = "xxxx"
  end

  def show

    @title = @event.name #為了變更Application的tile用
  end

  def create
    @event = Event.new( event_params )
    #代表我只要 :event這個key的值，且event_params定義在下面的protected內
    #同params[:event][:name]和params[:event][:description]
    # @event = Event.new( :name => params[:event][:name], :description => params[:event][:description])
    #代表我只要 :event這個key的值，原始寫法
    @event.save

    redirect_to :action => "index"
  end

  def edit
  end

  def update
    @event.update( event_params )

    # redirect_to :action => "index"
    redirect_to :action => :show, :id => @event
  end

  def destroy
    @event.destroy

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
