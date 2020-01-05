class TweetsController < ApplicationController
  def index
    @tweet = Tweet_review.find(1)
  end
end
