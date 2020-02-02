class EventWorker
  include Sidekiq::Worker
  #リトライはしない
  sidekiq_options queue: :event, retry: false

  def perform(id)
    #@event = Event.find(id)
    @theme = Theme.where(user_id: id).order(created_at: :asc)

    puts "動作確認中"

    
    return
  end
end