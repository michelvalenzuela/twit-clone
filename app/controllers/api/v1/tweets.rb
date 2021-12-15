module API
    module V1
      class Tweets < Grape::API
        include API::V1::Defaults
            resource :tweets do
              desc "Return all Tweets"
              get "" do
                Tweet.all
                
              end


            desc "Return a Tweet"
              params do
                requires :id, type: Integer, desc: "ID of the Tweet"
              end
              get ":id" do
                Tweet.where(id: permitted_params[:id]).first!
              end

            desc 'Create a Tweet Object'
            params do
              
                #requires :user_id, type: Integer, allow_blank: false
                requires :tweet, type: String, allow_blank: false
                optional :retweet_id ,type: Integer
            end
            post do
              tweet = Tweet.new(declared(params))
              tweet.user_id = @user.id
              tweet.save
              
              { tweet: tweet, message: 'Tweet Created Successfull'}
              
            end

            desc 'Update existing Tweet Object'
            params do
              requires :tweet, type: String, allow_blank: false
              
            end
            route_param :id do
              put do
                tweet = Tweet.find(params[:id])
                tweet.update(declared(params))
                { message: 'Tweet Updated..'}
              rescue ActiveRecord::RecordNotFound
                error!('record not found', 404)
              end
            end



            desc 'Deletes existing movie object'
            params do
              requires :id, type: Integer
            end
              delete ':id' do
                tweet = Tweet.find(params[:id])
                    if tweet.user_id == @user.id
                      tweet.delete
                        { message: 'Tweet Deleted'}
                    else
                        { message: 'El tweet que se esta intentando eliminar no le pertenece'}
                  end
                  { message: 'Tweet Deleted'}
              rescue ActiveRecord::RecordNotFound
                  error!('Record not found', 404)
              end
        
          end
        end
    end
end