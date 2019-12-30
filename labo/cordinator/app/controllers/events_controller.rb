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
      url: SecureRandom.urlsafe_base64
    )

    #ランダムなURLトークンの生成
    #@event.url = time.strftime('%Y%m%d%H:%M:%S').to_s
    #@event.url = SecureRandom.urlsafe_base64

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

  def set_event_url
    @event_url = Event.find_by(url_token: params[:url_token])
  end
end
