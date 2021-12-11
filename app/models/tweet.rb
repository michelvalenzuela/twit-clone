class Tweet < ApplicationRecord
    TIME_ZONE = "Santiago"
    
    has_and_belongs_to_many :tags
    belongs_to :user
    belongs_to :retweet, class_name: 'Tweet',  foreign_key: 'retweet_id',optional: true
    
    acts_as_votable

    paginates_per 25


    after_create do 

      hashtags = self.tweet.scan(/#\w+/)
      hashtags.uniq.map do |hashtag|
        tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
        self.tags << tag
      end

    end

    before_update do 
       self.tags.clear #we delete all and add again.
       hashtags = self.tweet.scan(/#\w+/)
       hashtags.uniq.map do |hashtag|
        tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
        self.tags << tag
      end
    end

    def time_since_publish
        start_date = self.created_at.in_time_zone(TIME_ZONE)
        time_now = Time.now.in_time_zone(TIME_ZONE)
    
        t = time_now - start_date
    
        if t < 59.minutes
          mins = (t / 1.minute).round
          mins == 1 ? "#{mins} minuto" : "#{mins} minutos"
        else
          hours = (t / 1.hour).round
          hours == 1 ? "#{hours} hora" : "#{hours} horas"
        end
      end   

   

end
