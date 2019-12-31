class EventsController < ApplicationController
  before_action :set_event_url, only: %i[create view share]
  def index
  end

  def create
    require 'securerandom'

    @event = Event.new(
      title: params[:title],
      memo: params[:memo],
      candidate_date: params[:calendar],
      url: SecureRandom.urlsafe_base64,
      candidate_count: "0人"
    )
    count = params[:calendar].count('\n')

    #@event.candidate_count = "0人-0人-0人/" * count

    if @event.save
      redirect_to("/events/create/#{@event.id}")
    else
      redirect_to("/meetings/index")
    end
  end

  def view
    @event = Event.find(params[:id])

  end

  def share
    @event = Event.find(params[:id])

    if @event.url != params[:url]
      flash[:notice] = "URLが間違っています"
      redirect_to(root_path)
    end

    @event_s = @event.candidate_date.split("\r\n")
  end

  def update
    @event = Event.find(params[:id])
    #参会者登録処理
    #検証中

    if params[:status0] == "○"
      @event.candidate_count = params[:name]
    end

    if @event.save
      flash[:notice] = "登録しました"
      redirect_to("/share/#{@event.id}/#{@event.url}")
    else
      render("/share/#{@event.id}/#{@event.url}")
    end


  end

  def set_event_url
    @event_url = Event.find_by(url_token: params[:url_token])
  end
end
