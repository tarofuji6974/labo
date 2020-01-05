class CommentsController < ApplicationController
  def create
    Comment.create(text: params[:text], tweet_id: params[:tweet_id], user_id: current_user.id)
    redirect_to "/tweets/#{@comment.tweet.id}"
  end

  private
  def comment_params
    params.permit(:text,:tweet_id)
  end
end
