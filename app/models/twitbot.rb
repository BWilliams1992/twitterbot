class Twitbot < ApplicationRecord
  has_many :tweets, dependent: :destroy
  belongs_to :user
  has_one_attached :spreadsheet

  def spreadsheet_path
      ActiveStorage::Blob.service.path_for(spreadsheet.key)
  end

  #builds and returns an array containing all the tweets in the twitterbot
  #that have not been sent yet
  def unsent
    @unsent = []

    self.tweets.each do |tweet|
      if tweet.used == false
        @unsent.push(tweet)
      else
        next
      end

    end
    return @unsent
  end

  def spreadsheet_check
    @spreadsheet = CSV.read(self.spreadsheet_path)
    @duplicate = []

    @spreadsheet.each do |item|
      @fail = false
      @duplicate.each do |check|

        if item == check
          @fail = true
        else
          next
        end

      end

      if @fail == false
        @duplicate.push(item)
      end

    end
    return @duplicate
  end

end
