class CreateTweetReviews < ActiveRecord::Migration
  def change
    create_table :tweet_reviews do |t|
        t.string      :name
        t.text        :text
        t.text        :image
        t.timestamps
    end
  end
end
