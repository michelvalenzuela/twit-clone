class TweetsController < ApplicationController
 
  before_action :set_tweet, only: %i[ show edit update destroy retweet]
  before_action :authenticate_user!, except: [:index, :show]
  # GET /tweets or /tweets.json
  USERS_FOLLOW = 9

  def index
    @users = User.all.limit(USERS_FOLLOW)
    @tweet = Tweet.new
    @query = params[:query]
    if @query.nil?
      @tweets = Tweet.page params[:page]
    else
      @tweets = Tweet.where("tweets.tweet ILIKE ?",["%#{@query}%"]).page(params[:page])
      @users = User.where("users.name ILIKE ?",["%#{@query}%"]).page(params[:page])
    end
    
    
    @feed_items = current_user.feed.page params[:page] unless current_user.nil?
    @tagg = Tag.all
    
  end
  
  def hashtags
    
    @tag = Tag.find_by(name: params[:name])
    @tweets = @tag.tweets 
    @tweet = Tweet.new
    @tweeets = Tag.page params[:page]
  end

  # GET /tweets/1 or /tweets/1.json
  def show
    @user = User.find(params[:id])
    
  end

  # GET /tweets/new
  def new
    @tweet = current_user.tweets.new
    @retweet = Tweet.find(params["tweet_id"])
    if @retweet.nil?
      @tweet = current_user.tweets.new
    else
      @tweet = current_user.tweets.new
      @retweet.increment!(:retweet_count)

    end

  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.liked_by current_user
    @tweet.increment!(:likes_count)
    redirect_to '/'
  end
  
  def dislike
    @tweet = Tweet.find(params[:id])
    @tweet.disliked_by current_user
    @tweet.decrement!(:likes_count)
    redirect_to '/'
  end

  # GET /tweets/1/edit
  def edit
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Tweet.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # POST /tweets or /tweets.json
  def create
   
    @tweet = current_user.tweets.new(tweet_params)
    
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to root_path, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    if not @tweet.retweet_id.nil?
      @tweet.decrement!(:retweet_count)
      end
    @tweet.destroy
    
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end

  end


  def retweet
    
    tweet = current_user.tweets.new(retweet_id: @tweet.id)
     
    if tweet.save

      redirect_to root_path
        
    else
        redirect_to :back, alert: "unable to retweet"
    
    end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:tweet, :retweet_id).merge(user: current_user)
    end

    

  

end
