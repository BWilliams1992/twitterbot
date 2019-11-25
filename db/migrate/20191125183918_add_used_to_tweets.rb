class AddUsedToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :used, :boolean
  end
end
