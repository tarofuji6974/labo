class EventsController < ApplicationController
  def index
  end

  def create
    require 'date'

    @event = Event.new(
      title: params[:title],
      memo: params[:memo],
      candidate_date: params[:calendar]
    )

    time = Time.now

    @event.url = time.strftime('%Y%m%d%H:%M:%S').to_s
    #te
    if @event.save
      redirect_to("/events/create/#{@event.id}")
    else
      redirect_to("/meetings/index")
    end
  end

  def view
    @event = Event.find(params[:id])
    
  end
end
