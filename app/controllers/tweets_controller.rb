class TweetsController < ApplicationController


  def check_for_dupe
    #passes params to temp new tweet
    @tweet = Tweet.new(tweet_params)
    #finds current twitbot
    @twitbot = Twitbot.find(params[:twitbot_id])
    #creates an array of tweets from the current twitbot
    @tweets = @twitbot.tweets.all
    #sets return boolean inital value to false
    @is_dupe = false
    #loops through each tweet in the twitbot and check to see if it matches
    #the current temporary tweet. If a match is found sets return value to true
    @tweets.each do |check|
      if check.content == @tweet.content
        @is_dupe = true
      else
        next
      end
      puts @is_dupe.to_s + "<<<< HELLO LOOK HERE IS WHAT U WANNA CHECK <<<<<<"
    end
    return @is_dupe
  end


  def create
    if check_for_dupe == false
      @twitbot = Twitbot.find(params[:twitbot_id])
      @tweet = @twitbot.tweets.create(tweet_params)
      redirect_to twitbot_path(@twitbot)
    else
      redirect_to twitbot_path(@twitbot)
    end
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
