class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.order(tdate: :DESC)
  end
  
  def show
    @tweet = Tweet.find(params[:id])
  end
  
  def new
    @tweet = Tweet.new
  end
  
  def create
    @tweet = Tweet.new(message: params[:tweet][:message], tdate: Time.current, image: params[:tweet][:image]&.read)
    if @tweet.save
      flash[:notice] = 'ツイートしました'
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit
    @tweet = Tweet.find(params[:id])
  end
  
  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(message: params[:tweet][:message], image: params[:tweet][:image]&.read)
      flash[:notice] = '編集しました'
      redirect_to root_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @tweet = Tweet.find(params[:id])
    if @tweet.destroy
      flash[:notice] = '削除しました'
    end
    redirect_to root_path
  end
  
  def get_image
    @tweet = Tweet.find(params[:id])
    send_data @tweet.image, disposition: :inline, type: 'image/png'
  end
end
