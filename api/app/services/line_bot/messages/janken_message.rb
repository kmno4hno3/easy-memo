class SampleMessage
  include LineBot::Messages::Concern::Carouselable
  def send
     carousel('alter_text', [bubble])
  end

  def bubble
    # ここにペースト
  end
end