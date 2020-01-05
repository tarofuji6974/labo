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
    #検証中

    @test = ''
    @test2 = ''
    @hash = {}
    @hash_json = ''
    @sample = { a: 1, b: 2, c: 3 }
    if @event.candidate_count != '0人'
      #hash = {ruby:"rails",python:"Django",php:"cakePHP"}
      @test = @event.candidate_count.scan(/「name:(\w+)」/)
      @test2 =@event.candidate_count.scan(/status:(\w+)/)


      ary = [@test, @test2].transpose
      @hash_json = Hash[*ary.flatten]

      @test.each_with_index do |test,i|
        @hash.store(test,@test2[i].join.split("chk"))
      end
      #@hash = Hash[*@hash.flatten]

      #@hash_json = @hash.to_json.html_safe

    end
  end

  def update
    @event = Event.find(params[:id])
    #参会者登録処理
    #検証中
    if params[:name] != nil
      @event.candidate_count += "///「name:" + params[:name] + 
                              "」//「status:" + params[:hidden_status_data] + 
                              "」"
      else
        render("/share/#{@event.id}/#{@event.url}")
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
