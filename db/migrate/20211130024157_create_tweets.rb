class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.belongs_to :user
      t.text :tweet
      t.timestamps
    end
  end
end
