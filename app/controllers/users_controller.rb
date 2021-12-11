class UsersController < ApplicationController

    before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
        :following, :followers]

    def feed
            following_ids = "SELECT followed_id FROM relationships WHERE  follower_id = :user_id"
            Tweet.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
    end
    def show
       @tweet = Tweet.new
        @user = User.find(params[:id])
        @tweets = Tweet.page params[:page]
        @feed_items = current_user.feed.page params[:page]
    end

    def following
        @title = "Following"
        @user  = User.find(params[:id])
        @users = @user.following.paginate(page: params[:page])
        render 'show_follow'
      end
    
      def followers
        @title = "Followers"
        @user  = User.find(params[:id])
        @users = @user.followers.paginate(page: params[:page])
        render 'show_follow'
      end

     
    

end
