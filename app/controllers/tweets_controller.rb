class TweetsController < ApplicationController

  def create
    @twitbot = Twitbot.find(params[:twitbot_id])
    @tweet = @twitbot.tweets.create(tweet_params)
    redirect_to twitbot_path(@twitbot)
  end

  def destroy
    @twitbot = Twitbot.find(params[:twitbot_id])
    @tweet = @twitbot.tweets.find(params[:id])
    @tweet.destroy
    redirect_to twitbot_path(@twitbot)
  end

  private
    def tweet_params
      params.require(:tweet).permit(:content)
    end
end
