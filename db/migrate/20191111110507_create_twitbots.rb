class CreateTwitbots < ActiveRecord::Migration[6.0]
  def change
    create_table :twitbots do |t|
      t.string :title
      t.text :notes

      t.timestamps
    end
  end
end
