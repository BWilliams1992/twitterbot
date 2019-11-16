class AddUserToTwitbot < ActiveRecord::Migration[6.0]
  def change
    add_reference :twitbots, :user, null: false, foreign_key: true
  end
end
