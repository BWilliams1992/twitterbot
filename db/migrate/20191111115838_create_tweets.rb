class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.text :content
      t.references :twitbot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
