class EventWorker
  include Sidekiq::Worker
  #リトライはしない
  sidekiq_options queue: :event, retry: false

  def perform
    #@event = Event.find(id)
    @theme = Theme.all
    
    return
  end
end